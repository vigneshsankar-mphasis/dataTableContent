import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGridScreen(),
    );
  }
}

class ProductGridScreen extends StatefulWidget {
  @override
  _ProductGridScreenState createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  List<PlutoRow> allRows = []; // Stores all data
  List<PlutoRow> displayedRows = []; // Stores filtered data
  List<PlutoColumn> columns = [];
  PlutoGridStateManager? stateManager;
  String searchQuery = '';
  int currentPage = 1;
  int pageSize = 10;
  int totalProducts = 0;
  bool isLoading = true;
  final List<int> pageSizeOptions = [5, 10, 15, 20];

  @override
  void initState() {
    super.initState();
    initializeColumns();
    fetchProducts();
  }

  void initializeColumns() {
    columns = [
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Title',
        field: 'title',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Price',
        field: 'price',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Category',
        field: 'category',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/products?limit=$pageSize&skip=${(currentPage - 1) * pageSize}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        totalProducts = data['total'];
        List products = data['products'];

        setState(() {
          allRows = products.map((product) {
            return PlutoRow(cells: {
              'id': PlutoCell(value: product['id']),
              'title': PlutoCell(value: product['title']),
              'price': PlutoCell(value: product['price']),
              'category': PlutoCell(value: product['category']),
            });
          }).toList();

          // Display full data initially
          displayedRows = List.from(allRows);
          isLoading = false;
        });

        // Refresh PlutoGrid after setting data
        updateGridRows(displayedRows);
      } else {
        print('Failed to fetch products. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchFilter(String query) {
    searchQuery = query.toLowerCase();

    setState(() {
      // Filter rows based on search query
      displayedRows = allRows.where((row) {
        final title = row.cells['title']!.value.toString().toLowerCase();
        return title.contains(searchQuery);
      }).toList();

      // Refresh PlutoGrid with new rows
      updateGridRows(displayedRows);
    });
  }

  void updateGridRows(List<PlutoRow> newRows) {
    if (stateManager != null) {
      stateManager!.removeAllRows(); // Remove existing rows
      stateManager!.appendRows(newRows); // Add filtered rows
    }
  }

  void nextPage() {
    if ((currentPage * pageSize) < totalProducts) {
      setState(() {
        currentPage++;
      });
      fetchProducts();
    }
  }

  void prevPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchProducts();
    }
  }

  void changePageSize(int newSize) {
    setState(() {
      pageSize = newSize;
      currentPage = 1;
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Grid'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchFilter,
              decoration: InputDecoration(
                labelText: 'Search Product',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          isLoading
              ? Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
              : Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: displayedRows, // Display the filtered data
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                updateGridRows(displayedRows); // Ensure grid updates on load
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print('Cell changed: ${event.value}');
              },
              configuration: PlutoGridConfiguration(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: prevPage,
                  child: Text('Previous'),
                ),
                SizedBox(width: 20),
                Text('Page $currentPage of ${(totalProducts / pageSize).ceil()}'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: nextPage,
                  child: Text('Next'),
                ),
                SizedBox(width: 20),
                DropdownButton<int>(
                  value: pageSize,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      changePageSize(newValue);
                    }
                  },
                  items: pageSizeOptions.map((size) {
                    return DropdownMenuItem<int>(
                      value: size,
                      child: Text('$size per page'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
