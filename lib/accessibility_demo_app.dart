import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(AccessibilityDemoApp());
}

class AccessibilityDemoApp extends StatelessWidget {
  const AccessibilityDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Accessibility POC',
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AccessibilityDemoPage(),
    );
  }
}

class AccessibilityDemoPage extends StatefulWidget {
  const AccessibilityDemoPage({super.key});

  @override
  _AccessibilityDemoPageState createState() => _AccessibilityDemoPageState();
}

class _AccessibilityDemoPageState extends State<AccessibilityDemoPage> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;
  late PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
    columns = [
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Age',
        field: 'age',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Country',
        field: 'country',
        type: PlutoColumnType.select(['USA', 'Canada', 'India']),
      ),
    ];

    rows = List.generate(5, (index) {
      return PlutoRow(cells: {
        'name': PlutoCell(value: 'User $index'),
        'age': PlutoCell(value: 20 + index),
        'country': PlutoCell(value: 'USA'),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Web Accessibility POC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Accessible Form', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
              items: ['USA', 'Canada', 'India'].map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            Text('Accessible Data Table', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                },
                configuration: PlutoGridConfiguration(
                  //enableColumnBorder: true,
                  style: PlutoGridStyleConfig(
                    enableGridBorderShadow: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
