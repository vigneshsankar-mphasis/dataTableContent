// main.dart
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlutoGrid Table',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TableScreen(),
    );
  }
}

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late PlutoGridStateManager stateManager;
  final List<PlutoColumn> columns = getTableColumns();
  final List<PlutoRow> rows = getTableRows();

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Id', fields: ['has_rim_no'], expandedColumn: true,backgroundColor: Colors.black12,),
    PlutoColumnGroup(title: 'Information', fields: ['rim_no', 'owner_no'],backgroundColor: Colors.black12,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PlutoGrid Table')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          columnGroups: columnGroups,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          configuration: PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
              rowHeight: 450,
              activatedBorderColor: Colors.blue,
              // also check box select color and entire row select active color
              activatedColor: Colors.white30,
              // select entire row
              borderColor: Colors.grey,
              // common border color
              cellColorGroupedRow: Colors.brown,
              cellColorInEditState: Colors.white,
              // Inside edit field background
              cellColorInReadOnlyState: Colors.white,
              // Inside read only edit field background
              //header
              //checkedColor: Colors.grey,
              cellTextStyle: TextStyle(color: Colors.black, fontSize: 12),
              // Inside and common text color style
              enableRowColorAnimation: false,
              // select row to row animation
              columnTextStyle: TextStyle(color: Colors.black, fontSize: 12),
              // header size and style
              gridBorderRadius: BorderRadius.circular(5),
              gridPopupBorderRadius: BorderRadius.circular(5),
              gridBackgroundColor: Colors.white, // overall grid table background color
              rowColor: Colors.white, //particular given row background color

               // columnHeight:500, use default
              //rowHeight: 50 use default
            ),
            columnSize: PlutoGridColumnSizeConfig(
              autoSizeMode: PlutoAutoSizeMode.scale,
              resizeMode: PlutoResizeMode.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// table_columns.dart
List<PlutoColumn> getTableColumns() {
  return [
    PlutoColumn(
      title: 'HasRIMNo',
      field: 'has_rim_no',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      applyFormatterInEditing: false,
      enableDropToResize: false,
      type: PlutoColumnType.select(['yes', 'no'],
          enableColumnFilter: false, defaultValue: ''),
      // type: PlutoColumnType.text(),
      // renderer: (rendererContext) => CustomCheckboxCell(rendererContext: rendererContext),
      enableRowChecked: true,
    ),
    PlutoColumn(
      title: 'Rim No',
      field: 'rim_no',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Owner No',
      field: 'owner_no',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Nationality',
      field: 'nationality',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.select(
          ['India', 'US', 'UK', 'Noida', 'Russia', 'Canada']),
    ),
    PlutoColumn(
      title: 'Share Holding (%)',
      field: 'share_holding',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Resident (Y/N)',
      field: 'resident',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.select(['Yes', 'No']),
    ),
    PlutoColumn(
      title: 'Beneficial Ownership (%)',
      field: 'beneficial_ownership',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Identification Details',
      field: 'identification_details',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.select(['AE', 'Emirates', 'Dubai']),
    ),
    PlutoColumn(
      title: 'Identification Number',
      field: 'identification_number',
      backgroundColor: Colors.black12,
      suppressedAutoSize: false,
      enableColumnDrag: false,
      enableRowDrag: false,
      enableAutoEditing: false,
      enableHideColumnMenuItem: false,
      enableSetColumnsMenuItem: false,
      enableContextMenu: false,
      enableSorting: false,
      enableDropToResize: false,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Delete',
      field: 'delete',
      backgroundColor: Colors.black12,
      type: PlutoColumnType.text(),
      renderer: (rendererContext) {
        return IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // ScaffoldMessenger.of(rendererContext.context).showSnackBar(
            //   SnackBar(content: Text('Row deleted')),
            // );
          },
        );
      },
    ),
  ];
}

// table_rows.dart
List<PlutoRow> getTableRows() {
  return List.generate(
      10,
      (index) => PlutoRow(cells: {
            'has_rim_no': PlutoCell(value: ''),
            'rim_no': PlutoCell(value: 'RIM$index'),
            'owner_no': PlutoCell(value: 'OWN$index'),
            'nationality': PlutoCell(value: 'India'),
            'share_holding': PlutoCell(value: 50),
            'resident': PlutoCell(value: 'Yes'),
            'beneficial_ownership': PlutoCell(value: 25),
            'identification_details': PlutoCell(value: 'AE'),
            'identification_number': PlutoCell(value: 'ID$index'),
            'delete': PlutoCell(value: ''),
          }));
}
