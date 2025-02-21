import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TableProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TableScreen(),
      ),
    );
  }
}

// Table Screen
class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Web Table with Provider')),
      body: Column(
        children: [
          const Expanded(child: TableWidget()),
          const PaginationWidget(),
        ],
      ),
    );
  }
}

// Table Widget
class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TableProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: provider.getColumns(),
          rows: provider.getRows(),
        ),
      ),
    );
  }
}

// Pagination Widget
class PaginationWidget extends StatelessWidget {
  const PaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TableProvider>(context);
    final totalPages = (provider.data.length / provider.rowsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: provider.currentPage > 1 ? provider.previousPage : null,
        ),
        Text('Page ${provider.currentPage} of $totalPages'),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: provider.currentPage < totalPages ? provider.nextPage : null,
        ),
      ],
    );
  }
}

// Table Provider for State Management
class TableProvider extends ChangeNotifier {
  int currentPage = 1;
  int rowsPerPage = 2;

  List<Map<String, dynamic>> data = [
    {'Category': 'Electronics', 'Item': 'Laptop', 'Price': 1200},
    {'Category': 'Electronics', 'Item': 'Smartphone', 'Price': 800},
    {'Category': 'Furniture', 'Item': 'Chair', 'Price': 100},
    {'Category': 'Furniture', 'Item': 'Table', 'Price': 250},
    {'Category': 'Appliances', 'Item': 'Washing Machine', 'Price': 500},
    {'Category': 'Appliances', 'Item': 'Refrigerator', 'Price': 1000},
  ];

  List<DataColumn> getColumns() {
    return [
      DataColumn(label: Text('Category')),
      DataColumn(label: Text('Item')),
      DataColumn(label: Text('Price')),
    ];
  }

  List<DataRow> getRows() {
    int start = (currentPage - 1) * rowsPerPage;
    int end = (start + rowsPerPage).clamp(0, data.length);
    final paginatedData = data.sublist(start, end);

    return paginatedData.map((row) {
      return DataRow(cells: [
        DataCell(Text(row['Category'])),
        DataCell(Text(row['Item'])),
        DataCell(Text('\$${row['Price']}')),
      ]);
    }).toList();
  }

  void nextPage() {
    if (currentPage * rowsPerPage < data.length) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }
}
