import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductTable(),
    );
  }
}

class ProductTable extends StatefulWidget {
  const ProductTable({super.key});

  @override
  _ProductTableState createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  late PlutoGridStateManager stateManager;
  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];
  TextEditingController searchController = TextEditingController();
  int rowsPerPage = 5;
  int page = 1;
  int totalProducts = 0;
  List<dynamic> allProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        allProducts = data['products'];
        totalProducts = allProducts.length;
        updateRows();
      });
    }
  }

  void updateRows() {
    if (!mounted || stateManager == null) return; // Ensure widget is mounted and stateManager exists

    List<dynamic> filteredList = allProducts.where((product) {
      String searchText = searchController.text.toLowerCase();
      return product['title'].toLowerCase().contains(searchText);
    }).toList();

    int startIndex = (page - 1) * rowsPerPage;
    int endIndex = (startIndex + rowsPerPage) > filteredList.length
        ? filteredList.length
        : (startIndex + rowsPerPage);
    List<dynamic> paginatedList = filteredList.sublist(startIndex, endIndex);

    List<PlutoRow> updatedRows = paginatedList.map((product) {
      return PlutoRow(cells: {
        'id': PlutoCell(value: product['id']),
        'title': PlutoCell(value: product['title']),
        'price': PlutoCell(value: product['price']),
        'category': PlutoCell(value: product['category']),
      });
    }).toList();

    // Ensure stateManager is loaded before modifying rows
    if (stateManager!=null) {
      stateManager.removeAllRows();
      stateManager.appendRows(updatedRows);
    }
  }


  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Product',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      page = 1;
                      updateRows();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                },
                onChanged: (PlutoGridOnChangedEvent event) {},
                configuration: const PlutoGridConfiguration(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<int>(
                  value: rowsPerPage,
                  items: [5, 10, 15].map((e) {
                    return DropdownMenuItem<int>(
                      value: e,
                      child: Text(" $e "),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        rowsPerPage = value;
                        page = 1;
                        updateRows();
                      });
                    }
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: page > 1
                          ? () {
                        setState(() {
                          page--;
                          updateRows();
                        });
                      }
                          : null,
                    ),
                    Text("Page $page"),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: (page * rowsPerPage) < totalProducts
                          ? () {
                        setState(() {
                          page++;
                          updateRows();
                        });
                      }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
