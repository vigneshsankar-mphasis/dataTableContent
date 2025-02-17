import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/loading_screen_clock_ctnow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pluto Grid with API & Dynamic Select',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DataPage(),
    );
  }
}

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late PlutoGridStateManager stateManager;
  List<PlutoRow> rows = [];
  int currentPage = 1;
  int totalPages = 1;
  int pageSize = 10; // Default page size
  List<int> pageSizeOptions = [5, 10, 15];
  bool isLoading = false;
  String errorMessage = '';
  List<String> categoryOptions = []; // Stores unique category options

  List<PlutoColumn> columns = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetch data from API and update PlutoGrid
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = Uri.parse(
        'https://dummyjson.com/products?limit=$pageSize&skip=${(currentPage - 1) * pageSize}');
    print("Fetching data from: $url");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        /// Extract unique category options
        categoryOptions = (data['products'] as List)
            .map<String>((product) => product['category'].toString())
            .toSet()
            .toList(); // Ensures unique values

        print("Unique Categories: $categoryOptions");

        /// Update columns dynamically
        columns = [
          PlutoColumn(
            title: 'Select',
            field: 'select',
            type: PlutoColumnType.select(['Yes', 'No']),
            enableRowChecked: true,
          ),
          PlutoColumn(
            title: 'ID',
            field: 'id',
            type: PlutoColumnType.number(),
            enableSorting: true,
          ),
          PlutoColumn(
            title: 'Name',
            field: 'name',
            type: PlutoColumnType.text(),
            enableEditingMode: true,
          ),
          PlutoColumn(
            title: 'SKU',
            field: 'sku',
            type: PlutoColumnType.text(),
          ),
          PlutoColumn(
            title: 'Category',
            field: 'category',
            type: PlutoColumnType.select(categoryOptions), // Dynamic categories
          ),
          PlutoColumn(
            title: 'Price',
            field: 'price',
            type: PlutoColumnType.currency(),
          ),
        ];

        setState(() {
          rows = (data['products'] as List).map((product) {
            return PlutoRow(cells: {
              'select': PlutoCell(value: 'No'),
              'id': PlutoCell(value: product['id']),
              'name': PlutoCell(value: product['title'] ?? 'sample'),
              'sku': PlutoCell(value: product['brand'] ?? 'sku sample'),
              'category': PlutoCell(value: product['category']), // Dynamic Select
              'price': PlutoCell(value: product['price']),
            });
          }).toList();

          totalPages = (data['total'] / pageSize).ceil();
          isLoading = false;
        });

        print("Data Loaded Successfully!");
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load data: $error";
      });
      print("Fetch Error: $error");
    }
  }

  /// Navigates to the next page
  void _goToNextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
      fetchData();
    }
  }

  /// Navigates to the previous page
  void _goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchData();
    }
  }

  /// Updates page size and refreshes data
  void _changePageSize(int newSize) {
    setState(() {
      pageSize = newSize;
      currentPage = 1; // Reset to first page
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pluto Grid with API & Dynamic Select'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchData,
          ),
        ],
      ),
      body: Column(
        children: [
          if (errorMessage.isNotEmpty)
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.red[100],
              child: Text(errorMessage, style: TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: isLoading
                ? Center(child: LoadingScreen())
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setShowColumnFilter(true);
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                configuration: PlutoGridConfiguration(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Page size dropdown
                Text("Rows per page: "),
                DropdownButton<int>(
                  value: pageSize,
                  items: pageSizeOptions.map((size) {
                    return DropdownMenuItem<int>(
                      value: size,
                      child: Text(size.toString()),
                    );
                  }).toList(),
                  onChanged: (newSize) {
                    if (newSize != null) {
                      _changePageSize(newSize);
                    }
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _goToPreviousPage,
                  child: Text('Previous'),
                ),
                SizedBox(width: 20),
                Text('Page $currentPage of $totalPages'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _goToNextPage,
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
