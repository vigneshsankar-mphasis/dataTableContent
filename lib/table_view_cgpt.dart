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
        appBar: AppBar(title: const Text('Flutter Web Table Example')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SimpleTable(),
        ),
      ),
    );
  }
}

class SimpleTable extends StatelessWidget {
  const SimpleTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        // Header Row
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: const [
            TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold)))),
            TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold)))),
            TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)))),
          ],
        ),

        // Grouped Rows (Example for Row Group)
        TableRow(children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Electronics', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
          ),
          TableCell(child: SizedBox()), // Empty cell for spacing
          TableCell(child: SizedBox()), // Empty cell for spacing
        ]),

        TableRow(children: [
          TableCell(child: SizedBox()), // Empty for grouping
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Laptop'))),
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('\$1200'))),
        ]),

        TableRow(children: [
          TableCell(child: SizedBox()), // Empty for grouping
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Smartphone'))),
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('\$800'))),
        ]),

        // Another Group
        TableRow(children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Furniture', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ),
          ),
          TableCell(child: SizedBox()),
          TableCell(child: SizedBox()),
        ]),

        TableRow(children: [
          TableCell(child: SizedBox()), // Empty for grouping
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Chair'))),
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('\$100'))),
        ]),

        TableRow(children: [
          TableCell(child: SizedBox()), // Empty for grouping
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Table'))),
          TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('\$250'))),
        ]),
      ],
    );
  }
}
