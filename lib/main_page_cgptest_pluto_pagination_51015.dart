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
      title: 'PlutoGrid Pagination',
      home: ProductTable(),
    );
  }
}

class ProductTable extends StatefulWidget {
  @override
  _ProductTableState createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  List<PlutoRow> rows = [];
  int currentPage = 1;
  int pageSize = 10; // Default Page Size
  int totalItems = 0;
  PlutoGridStateManager? stateManager;
  final List<int> pageSizeOptions = [5, 10, 15, 20];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url = 'https://dummyjson.com/products?limit=$pageSize&skip=${(currentPage - 1) * pageSize}';
    print('Fetching: $url');

    final response = await http.get(Uri.parse(url));
    print('Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response Data: $data');

      setState(() {
        totalItems = data['total'];
        rows = data['products'].map<PlutoRow>((product) {
          return PlutoRow(cells: {
            'id': PlutoCell(value: product['id']),
            'title': PlutoCell(value: product['title']),
            'price': PlutoCell(value: product['price']),
          });
        }).toList();
      });

      // Ensure PlutoGrid updates rows dynamically
      if (stateManager != null) {
        stateManager!.refRows.clear();
        stateManager!.refRows.addAll(rows);
        stateManager!.notifyListeners();
      }
    } else {
      print('Error fetching data: ${response.body}');
    }
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
    fetchProducts();
  }

  void onPageSizeChanged(int newSize) {
    setState(() {
      pageSize = newSize;
      currentPage = 1; // Reset to first page when page size changes
    });
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PlutoGrid Pagination')),
      body: Column(
        children: [
          Expanded(
            child: PlutoGrid(
              columns: [
                PlutoColumn(title: 'ID', field: 'id', type: PlutoColumnType.number()),
                PlutoColumn(title: 'Title', field: 'title', type: PlutoColumnType.text()),
                PlutoColumn(title: 'Price', field: 'price', type: PlutoColumnType.number()),
              ],
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
              },
              onChanged: (PlutoGridOnChangedEvent event) {},
            ),
          ),
          PaginationControls(
            currentPage: currentPage,
            pageSize: pageSize,
            totalItems: totalItems,
            pageSizeOptions: pageSizeOptions,
            onPageChanged: onPageChanged,
            onPageSizeChanged: onPageSizeChanged,
          ),
        ],
      ),
    );
  }
}

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final List<int> pageSizeOptions;
  final Function(int) onPageChanged;
  final Function(int) onPageSizeChanged;

  PaginationControls({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.pageSizeOptions,
    required this.onPageChanged,
    required this.onPageSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    int totalPages = (totalItems / pageSize).ceil();
    if (totalPages == 0) return SizedBox.shrink(); // Hide if no data

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          value: pageSize,
          items: pageSizeOptions.map((size) {
            return DropdownMenuItem<int>(
              value: size,
              child: Text('$size'),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onPageSizeChanged(value);
          },
        ),
        SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        ),
        Text('Page $currentPage of $totalPages'),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
        ),
      ],
    );
  }
}
