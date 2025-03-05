import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TableScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late PlutoGridStateManager stateManager;
  PlutoRowGroupDelegate? rowGroupDelegate;

  @override
  void initState() {
    super.initState();

    rowGroupDelegate = PlutoRowGroupTreeDelegate(
      resolveColumnDepth: (column) => stateManager.columnIndex(column),
      showText: (cell) => true,
      showCount: false,
      showFirstExpandableIcon: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pluto Grid - Column & Row Grouping")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: _buildColumns(),
          rows: _buildRows(),
          columnGroups: _buildColumnGroups(),
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
            if (rowGroupDelegate != null) {
              stateManager.setRowGroup(rowGroupDelegate);
            }
          },
          configuration: PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.scale),
          ),
        ),
      ),
    );
  }

  /// COLUMN DEFINITIONS
  List<PlutoColumn> _buildColumns() {
    return [
      PlutoColumn(
        title: 'S.No',
        field: 'sno',
        type: PlutoColumnType.text(),
        readOnly: true,
        width: 80,
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        readOnly: true,
        width: 150,
      ),
      PlutoColumn(
        title: 'Email',
        field: 'email',
        type: PlutoColumnType.text(),
        readOnly: true,
        width: 200,
      ),
      PlutoColumn(
        title: 'Mobile',
        field: 'mobile',
        type: PlutoColumnType.text(),
        readOnly: true,
        width: 150,
      ),
      PlutoColumn(
        title: 'RIM No',
        field: 'rim_no',
        type: PlutoColumnType.text(),
        renderer: (renderContext) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              renderContext.cell.value.toString(),
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          );
        },
        width: 100,
      ),
      PlutoColumn(
        title: 'Name of Borrower',
        field: 'borrower_name',
        type: PlutoColumnType.text(),
        renderer: (renderContext) {
          return Text(
            renderContext.cell.value.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          );
        },
        width: 150,
      ),
      PlutoColumn(
        title: 'Maximum Limit (AED)',
        field: 'max_limit',
        type: PlutoColumnType.number(),
        renderer: (renderContext) {
          return Text(
            '${renderContext.cell.value} AED',
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),
          );
        },
        width: 150,
      ),
    ];
  }

  /// ROW DATA WITH NESTED LIST

  List<PlutoRow> _buildRows() {
    PlutoRowType generateType(List<PlutoRow> children) {
      return PlutoRowType.group(
        expanded: true, // Ensures the group is expanded
        children: FilteredList<PlutoRow>(
          initialList: children,
        ),
      );
    }

    List<PlutoRow> childrenRows = [
      PlutoRow(
        cells: {
          'sno': PlutoCell(value: ''),
          'name': PlutoCell(value: 'vignesh first'),
          'email': PlutoCell(value: 'first@g.c'),
          'mobile': PlutoCell(value: ''),
          'rim_no': PlutoCell(value: '123-A'),
          'borrower_name': PlutoCell(value: 'Sub-V'),
          'max_limit': PlutoCell(value: 5000),
        },
      ),
      PlutoRow(
        cells: {
          'sno': PlutoCell(value: ''),
          'name': PlutoCell(value: 'vignesh second'),
          'email': PlutoCell(value: 'second@g.c'),
          'mobile': PlutoCell(value: ''),
          'rim_no': PlutoCell(value: '123-B'),
          'borrower_name': PlutoCell(value: 'Sub-V2'),
          'max_limit': PlutoCell(value: 3000),
        },
      ),
    ];

    return [
      PlutoRow(
        cells: {
          'sno': PlutoCell(value: 1),
          'name': PlutoCell(value: 'Vignesh'),
          'email': PlutoCell(value: 'v@gmail.com'),
          'mobile': PlutoCell(value: '09565851234'),
          'rim_no': PlutoCell(value: '123'),
          'borrower_name': PlutoCell(value: 'V'),
          'max_limit': PlutoCell(value: 10000),
        },
        type: generateType(childrenRows),
      ),
    ];
  }

  /// Fix for PlutoRowType.group() error
  List<PlutoRow> _buildRowsd() {
    return [
      PlutoRow(
        cells: {
          'sno': PlutoCell(value: 1),
          'name': PlutoCell(value: 'Vignesh'),
          'email': PlutoCell(value: 'v@gmail.com'),
          'mobile': PlutoCell(value: '09565851234'),
          'rim_no': PlutoCell(value: '123'),
          'borrower_name': PlutoCell(value: 'V'),
          'max_limit': PlutoCell(value: 10000),
        },
        type: PlutoRowType.group(
          expanded: true,
          children: FilteredList<PlutoRow>(
            initialList: [
              PlutoRow(
                cells: {
                  'sno': PlutoCell(value: '1.1'),
                  'name': PlutoCell(value: ''),
                  'email': PlutoCell(value: ''),
                  'mobile': PlutoCell(value: ''),
                  'rim_no': PlutoCell(value: '123-A'),
                  'borrower_name': PlutoCell(value: 'Sub-V'),
                  'max_limit': PlutoCell(value: 5000),
                },
              ),
              PlutoRow(
                cells: {
                  'sno': PlutoCell(value: '1.2'),
                  'name': PlutoCell(value: ''),
                  'email': PlutoCell(value: ''),
                  'mobile': PlutoCell(value: ''),
                  'rim_no': PlutoCell(value: '123-B'),
                  'borrower_name': PlutoCell(value: 'Sub-V2'),
                  'max_limit': PlutoCell(value: 3000),
                },
              ),
            ],
          ),
        ),
      ),
    ];
  }

  /// COLUMN GROUPING (Multi-Level Headers)
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(
      title: 'User Details',
      fields: ['sno', 'name', 'email', 'mobile'], // Ensure this is not empty
      backgroundColor: Colors.black12,
    ),
    PlutoColumnGroup(
      title: 'Categories',
      fields: ['category_list'], // Ensure this is not empty
      backgroundColor: Colors.black12,
    ),
  ];

  /// COLUMN GROUPING (Multi-Level Headers)
  List<PlutoColumnGroup> _buildColumnGroups() {
    return [
      PlutoColumnGroup(
          title: 'Basic Info', fields: ['sno', 'name', 'email', 'mobile']),
      PlutoColumnGroup(
        title: 'Facility Details',
        // fields: ['rim_no', 'borrower_name', 'max_limit'],
        children: [
          PlutoColumnGroup(title: 'RIM Details', fields: ['rim_no']),
          PlutoColumnGroup(
              title: 'Borrower Details',
              fields: ['borrower_name', 'max_limit']),
        ],
      ),
    ];
  }
}
