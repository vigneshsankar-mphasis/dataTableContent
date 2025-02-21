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
    PlutoColumnGroup(
      title: 'Customer',
      fields: ['rim_no', 'name'],
      backgroundColor: Colors.black12,
      titleTextAlign: PlutoColumnTextAlign.right
    ),
    PlutoColumnGroup(
      title: 'Existing',
      fields: ['crr', 'basic_of_crr'],
      backgroundColor: Colors.black12,
    ),
    PlutoColumnGroup(
      title: 'Proposed',
      fields: ['model_of_opt', 'crr_proposed', 'basic_of_proposed_crr'],
      backgroundColor: Colors.black12,
    ),
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
              gridBackgroundColor: Colors.white,
              // overall grid table background color
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
        title: 'Rating Id',
        field: 'rating_id',
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
        type: PlutoColumnType.number(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        readOnly: true),
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
      type: PlutoColumnType.number(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
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
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'CRR',
      field: 'crr',
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
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Basic of CRR',
      field: 'basic_of_crr',
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
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Model of OPT',
      field: 'model_of_opt',
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
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'CRR Proposed',
      field: 'crr_proposed',
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
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      readOnly: true,
    ),
    PlutoColumn(
        title: 'Basic of Proposed CRR',
        field: 'basic_of_proposed_crr',
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
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        readOnly: true),
    PlutoColumn(
        title: 'Details of Override \n(if any)',
        field: 'details_of_override',
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
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        readOnly: true),
    PlutoColumn(
      title: 'Proposed by Credited \n(if different)',
      field: 'proposed_by_credited',
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
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      type: PlutoColumnType.select(['11', '12', '13', '14', '15']),

      enableEditingMode: true,
      readOnly: false,
      renderer: (rendererContext) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(rendererContext.cell.value.toString()), // Show selected value
            ),
            const Icon(Icons.keyboard_arrow_down_rounded), // Always show dropdown icon
          ],
        );
      },

    ),
  ];
}

List<PlutoRow> getTableRows() {
  return [
    PlutoRow(cells: {
      'rating_id': PlutoCell(value: '123'),
      'rim_no': PlutoCell(value: 101),
      'name': PlutoCell(value: 'John Doe'),
      'crr': PlutoCell(value: 5),
      'basic_of_crr': PlutoCell(value: 'Standard'),
      'model_of_opt': PlutoCell(value: 3),
      'crr_proposed': PlutoCell(value: 6),
      'basic_of_proposed_crr': PlutoCell(value: 'Advanced'),
      'details_of_override': PlutoCell(value: 'None'),
      'proposed_by_credited': PlutoCell(value: '11'),
    }),
    PlutoRow(cells: {
      'rating_id': PlutoCell(value: '134'),
      'rim_no': PlutoCell(value: 102),
      'name': PlutoCell(value: 'Alice Smith'),
      'crr': PlutoCell(value: 4),
      'basic_of_crr': PlutoCell(value: 'Basic'),
      'model_of_opt': PlutoCell(value: 2),
      'crr_proposed': PlutoCell(value: 5),
      'basic_of_proposed_crr': PlutoCell(value: 'Intermediate'),
      'details_of_override': PlutoCell(value: 'Manual Adjustment'),
      'proposed_by_credited': PlutoCell(value: '12'),
    }),
    PlutoRow(cells: {
      'rating_id': PlutoCell(value: '143'),
      'rim_no': PlutoCell(value: 103),
      'name': PlutoCell(value: 'Robert Brown'),
      'crr': PlutoCell(value: 6),
      'basic_of_crr': PlutoCell(value: 'Custom'),
      'model_of_opt': PlutoCell(value: 4),
      'crr_proposed': PlutoCell(value: 7),
      'basic_of_proposed_crr': PlutoCell(value: 'Premium'),
      'details_of_override': PlutoCell(value: 'Risk Adjustment'),
      'proposed_by_credited': PlutoCell(value: '13'),
    }),
    PlutoRow(cells: {
      'rating_id': PlutoCell(value: '154'),
      'rim_no': PlutoCell(value: 104),
      'name': PlutoCell(value: 'Emma Wilson'),
      'crr': PlutoCell(value: 3),
      'basic_of_crr': PlutoCell(value: 'Basic'),
      'model_of_opt': PlutoCell(value: 2),
      'crr_proposed': PlutoCell(value: 4),
      'basic_of_proposed_crr': PlutoCell(value: 'Moderate'),
      'details_of_override': PlutoCell(value: 'Risk Override'),
      'proposed_by_credited': PlutoCell(value: '14'),
    }),
    PlutoRow(cells: {
      'rating_id': PlutoCell(value: '164'),
      'rim_no': PlutoCell(value: 105),
      'name': PlutoCell(value: 'Michael Lee'),
      'crr': PlutoCell(value: 7),
      'basic_of_crr': PlutoCell(value: 'Expert'),
      'model_of_opt': PlutoCell(value: 5),
      'crr_proposed': PlutoCell(value: 8),
      'basic_of_proposed_crr': PlutoCell(value: 'Elite'),
      'details_of_override': PlutoCell(value: 'Manual Override'),
      'proposed_by_credited': PlutoCell(value: '15'),
    }),
  ];
}
