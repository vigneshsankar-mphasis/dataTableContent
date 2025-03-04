import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(MaterialApp(
    home: GroupedTableScreen(),
  ));
}


class GroupedTableScreen extends StatefulWidget {
  @override
  _GroupedTableScreenState createState() => _GroupedTableScreenState();
}

class _GroupedTableScreenState extends State<GroupedTableScreen> {
  late PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pluto Grid Row & Column Group')),
      body: PlutoGrid(
        columns: _getColumns(),
        rows: _getRows(),
        columnGroups: _getColumnGroups(),
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
        },
        configuration: PlutoGridConfiguration(
          columnSize: PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.scale),
        ),
      ),
    );
  }

  List<PlutoColumn> _getColumns() {
    return [
      PlutoColumn(
        title: 'S.No',
        field: 'sno',
        type: PlutoColumnType.number(),
        readOnly: true,
        frozen: PlutoColumnFrozen.start,
      ),
      PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
      PlutoColumn(title: 'Email', field: 'email', type: PlutoColumnType.text()),
      PlutoColumn(title: 'Mobile', field: 'mobile', type: PlutoColumnType.text()),
      PlutoColumn(
        title: 'Categories',
        field: 'category_list',
        type: PlutoColumnType.text(),
        renderer: (renderContext) {
          List<dynamic> categories = renderContext.cell.value ?? [];
          return Table(
            border: TableBorder.all(color: Colors.black),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: const [
                  TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))))
                ],
              ),
              ...categories.map((cat) => TableRow(children: [
                TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text('${cat['rno']} - ${cat['name']}'))),
              ])).toList(),
            ],
          );
        },
      ),
    ];
  }

  List<PlutoColumnGroup> _getColumnGroups() {
    return [
      PlutoColumnGroup(title: 'User Details', fields: ['sno', 'name', 'email', 'mobile'], backgroundColor: Colors.black12),
      PlutoColumnGroup(title: 'Categories', fields: ['category_list'], backgroundColor: Colors.black12),
    ];
  }

  List<PlutoRow> _getRows() {
    return [
      PlutoRow(cells: {
        'sno': PlutoCell(value: 1),
        'name': PlutoCell(value: 'Vignesh'),
        'email': PlutoCell(value: 'v@gmail.com'),
        'mobile': PlutoCell(value: '09565851234'),
        'category_list': PlutoCell(value: [
          {'rno': '123', 'name': 'Laptop'},
          {'rno': '456', 'name': 'Smartphone'},
        ]),
      }),
      PlutoRow(cells: {
        'sno': PlutoCell(value: 2),
        'name': PlutoCell(value: 'Karthik'),
        'email': PlutoCell(value: 'karthik@example.com'),
        'mobile': PlutoCell(value: '09876543211'),
        'category_list': PlutoCell(value: [
          {'rno': '789', 'name': 'Tablet'},
          {'rno': '101', 'name': 'Headphones'},
        ]),
      }),
      PlutoRow(cells: {
        'sno': PlutoCell(value: 3),
        'name': PlutoCell(value: 'Arun'),
        'email': PlutoCell(value: 'arun@example.com'),
        'mobile': PlutoCell(value: '09765432122'),
        'category_list': PlutoCell(value: [
          {'rno': '202', 'name': 'Monitor'},
          {'rno': '303', 'name': 'Keyboard'},
        ]),
      }),
      PlutoRow(cells: {
        'sno': PlutoCell(value: 4),
        'name': PlutoCell(value: 'Priya'),
        'email': PlutoCell(value: 'priya@example.com'),
        'mobile': PlutoCell(value: '09654321099'),
        'category_list': PlutoCell(value: [
          {'rno': '404', 'name': 'Desk'},
          {'rno': '505', 'name': 'Chair'},
        ]),
      }),
      PlutoRow(cells: {
        'sno': PlutoCell(value: 5),
        'name': PlutoCell(value: 'Divya'),
        'email': PlutoCell(value: 'divya@example.com'),
        'mobile': PlutoCell(value: '09543210988'),
        'category_list': PlutoCell(value: [
          {'rno': '606', 'name': 'Printer'},
          {'rno': '707', 'name': 'Scanner'},
        ]),
      }),
    ];
  }

}