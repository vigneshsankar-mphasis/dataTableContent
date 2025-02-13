import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pluto Grid Demo',
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

  List<PlutoColumn> columns = [
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
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Price',
      field: 'price',
      type: PlutoColumnType.currency(),
    ),
  ];

  List<PlutoRow> rows = List.generate(
    100,
        (index) => PlutoRow(cells: {
          'select': PlutoCell(value: 'No'),  // Use a valid option
      'id': PlutoCell(value: index + 1),
      'name': PlutoCell(value: 'Product ${index + 1}'),
      'sku': PlutoCell(value: 'SKU-${index + 1}'),
      'category': PlutoCell(value: 'Category-${index + 1}'),
      'price': PlutoCell(value: (index + 1) * 10.0),
    }),
  );

  void _printSelectedIndexes() {
    List<int> selectedIndexes = [];
    for (int i = 0; i < rows.length; i++) {
      if (stateManager.rows[i].checked == true) {
        selectedIndexes.add(i);
      }
    }
    print('Selected row indices: $selectedIndexes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pluto Grid Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _printSelectedIndexes,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                for (var row in rows) {
                  row.setChecked(false); // Uncheck all checkboxes
                }
                stateManager.notifyListeners(); // Refresh the grid
              });
            },
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            print(event);
          },
          configuration: PlutoGridConfiguration(

          ),
        ),
      ),
    );
  }
}
