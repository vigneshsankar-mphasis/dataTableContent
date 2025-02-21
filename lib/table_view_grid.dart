import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Reusable Table Component')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomTable(),
        ),
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  const CustomTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tableData = [
      {"category": "Electronics", "items": []},
      {"category": "", "items": [{"name": "Laptop", "price": 1200}, {"name": "Smartphone", "price": 800}]},
      {"category": "Furniture", "items": []},
      {"category": "", "items": [{"name": "Chair", "price": 100}, {"name": "Table", "price": 250}]},
    ];

    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        buildHeaderRow(["Category", "Item", "Price"]),
        ...tableData.expand((row) {
          if (row["category"]!.isNotEmpty) {
            return [buildCategoryRow(row["category"])];
          } else {
            return row["items"].map<TableRow>((item) => buildDataRow(item["name"], item["price"])).toList();
          }
        }),
      ],
    );
  }
}

// ✅ Header Row Component
TableRow buildHeaderRow(List<String> headers) {
  return TableRow(
    decoration: BoxDecoration(color: Colors.grey[300]),
    children: headers
        .map((header) => tableCell(header, isBold: true, padding: 8))
        .toList(),
  );
}

// ✅ Category Row Component (Group)
TableRow buildCategoryRow(String category) {
  return TableRow(children: [
    tableCell(category, isBold: true, color: Colors.blue),
    emptyCell(),
    emptyCell(),
  ]);
}

// ✅ Data Row Component
TableRow buildDataRow(String item, int price) {
  return TableRow(children: [
    emptyCell(), // Empty for grouping
    tableCell(item),
    tableCell("\$$price"),
  ]);
}

// ✅ Table Cell Component
Widget tableCell(String text, {bool isBold = false, Color? color, double padding = 8}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Text(
      text,
      style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color ?? Colors.black),
    ),
  );
}

// ✅ Empty Cell Component
Widget emptyCell() => const SizedBox();
