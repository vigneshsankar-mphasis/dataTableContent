import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Pluto Grid Table")),
        body: PlutoGridExample(),
      ),
    );
  }
}

class PlutoGridExample extends StatefulWidget {
  const PlutoGridExample({super.key});

  @override
  _PlutoGridExampleState createState() => _PlutoGridExampleState();
}

class _PlutoGridExampleState extends State<PlutoGridExample> {
  late PlutoGridStateManager stateManager;
  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    // PlutoColumnGroup(title: 'Id', fields: ['has_rim_no'], expandedColumn: true,backgroundColor: Colors.black12,),
    // PlutoColumnGroup(title: 'Information', fields: ['rim_no', 'owner_no'],backgroundColor: Colors.black12,),
    PlutoColumnGroup(title: 'User Details', fields: ['sno', 'name', 'email', 'mobile'],backgroundColor: Colors.black12,),
    PlutoColumnGroup(title: 'Categories', fields: ['category_list'],backgroundColor: Colors.black12,),
  ];


  List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'S.No',
      field: 'sno',
      type: PlutoColumnType.text(),
      width: 80,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Mobile',
      field: 'mobile',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Category List',
      field: 'category_list',
      type: PlutoColumnType.text(),

      // renderer: (PlutoColumnRendererContext renderContext) {
      //   List<dynamic> categories = renderContext.cell.value;
      //   return SizedBox(
      //     height: 60, // Set height dynamically if needed
      //     child: ListView.builder(
      //       shrinkWrap: true,
      //       physics: NeverScrollableScrollPhysics(),
      //       itemCount: categories.length,
      //       itemBuilder: (context, index) {
      //         final cat = categories[index];
      //         return Text("RNO: ${cat['rno']}, Name: ${cat['name']}",
      //             style: TextStyle(fontSize: 12, color: Colors.black87));
      //       },
      //     ),
      //   );
      // },


      // renderer: (PlutoColumnRendererContext renderContext) {
      //   List<dynamic> categories = renderContext.cell.value;
      //   return SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: categories.map((cat) {
      //         return Text("RNO: ${cat['rno']}, Name: ${cat['name']}",
      //             style: TextStyle(fontSize: 12, color: Colors.black87));
      //       }).toList(),
      //     ),
      //   );
      // },


      renderer: (PlutoColumnRendererContext renderContext) {
        List<dynamic> categories = renderContext.cell.value;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Expanded(
                    child: Text("R.NO",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  Expanded(
                    child: Text("Name",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
              ),
              Divider(thickness: 1), // Add a line separator

              // Data Rows
              ...categories.map((cat) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(cat['rno'], style: TextStyle(fontSize: 12, color: Colors.black87)),
                    ),
                    Expanded(
                      child: Text(cat['name'], style: TextStyle(fontSize: 12, color: Colors.black87)),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },


      // renderer: (PlutoColumnRendererContext renderContext) {
      //   List<dynamic> categories = renderContext.cell.value;
      //   return SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: categories.map((cat) {
      //         return Container(
      //           padding: EdgeInsets.symmetric(vertical: 4),
      //           child: Row(
      //             children: [
      //               Expanded(child: Text("R.NO: ${cat['rno']}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
      //               Expanded(child: Text("Name: ${cat['name']}", style: TextStyle(fontSize: 12))),
      //             ],
      //           ),
      //         );
      //       }).toList(),
      //     ),
      //   );
      // },

      // renderer: (PlutoColumnRendererContext renderContext) {
      //   List<dynamic> categories = renderContext.cell.value;
      //   return SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: categories.map((cat) {
      //         return Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("R.NO: ${cat['rno']}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      //             SizedBox(width: 10), // Spacing between columns
      //             Text("Name: ${cat['name']}", style: TextStyle(fontSize: 12)),
      //           ],
      //         );
      //       }).toList(),
      //     ),
      //   );
      // },

    ),
  ];

  List<PlutoRow> rows = [
    PlutoRow(cells: {
      'sno': PlutoCell(value: '1'),
      'name': PlutoCell(value: 'Vignesh'),
      'email': PlutoCell(value: 'v@gmail.com'),
      'mobile': PlutoCell(value: '09565851234'),
      'category_list': PlutoCell(value: [
        {'rno': '123', 'name': 'Category A'},
        {'rno': '456', 'name': 'Category B'},
        {'rno': '456', 'name': 'Category C'},
        {'rno': '456', 'name': 'Category D'},
        {'rno': '456', 'name': 'Category E'},
        {'rno': '456', 'name': 'Category F'},
        {'rno': '456', 'name': 'Category G'},
        {'rno': '456', 'name': 'Category H'},
      ]),
    }),
    PlutoRow(cells: {
      'sno': PlutoCell(value: '2'),
      'name': PlutoCell(value: 'Kumar'),
      'email': PlutoCell(value: 'kumar@gmail.com'),
      'mobile': PlutoCell(value: '0987654321'),
      'category_list': PlutoCell(value: [
        {'rno': '789', 'name': 'Category C'},
        {'rno': '789', 'name': 'Category C'},
        {'rno': '789', 'name': 'Category C'},
        {'rno': '789', 'name': 'Category C'},
        {'rno': '789', 'name': 'Category C'},
        {'rno': '101', 'name': 'Category D'},
      ]),
    }),
  ];

  @override
  Widget build(BuildContext context) {

    return PlutoGrid(
      columns: columns,
      rows: rows,
      columnGroups: columnGroups,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
      },
      configuration: PlutoGridConfiguration(
        style: PlutoGridStyleConfig(
          rowHeight: 250,
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
    );
  }
}
