import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Table',
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
  DateTime? _startDate;
  DateTime? _endDate;
  List<DataRow> _filteredRows = [];
  int _rowsPerPage = 10;
  final List<int> _rowsPerPageOptions = [10, 20, 50, 100];

  final List<Map<String, dynamic>> _data = List.generate(
    150,
        (index) => {
      "id": index + 1,
      "name": "Item ${index + 1}",
      "date": DateTime.now().subtract(Duration(days: index)),
    },
  );

  @override
  void initState() {
    super.initState();
    _filterData();
  }

  void _filterData() {
    setState(() {
      _filteredRows = _data
          .where((item) {
        if (_startDate != null && item['date'].isBefore(_startDate!)) {
          return false;
        }
        if (_endDate != null && item['date'].isAfter(_endDate!)) {
          return false;
        }
        return true;
      })
          .map(
            (item) => DataRow(cells: [
          DataCell(Text(item['id'].toString())),
          DataCell(Text(item['name'])),
          DataCell(Text(DateFormat('yyyy-MM-dd').format(item['date']))),
              DataCell(Text(item['name'])),
              DataCell(Text(item['name'])),
              DataCell(Text(item['name'])),
              DataCell(Text(item['name'])),
              DataCell(Text(item['name'])),
        ]),
      )
          .toList();
    });
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _filterData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paginated Table with Date Range')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _pickDateRange,
              child: Text('Select Date Range'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                header: Text('Records'),
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Active')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Status')),
                ],
                source: _TableDataSource(_filteredRows),
                rowsPerPage: _rowsPerPage,
                availableRowsPerPage: _rowsPerPageOptions,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value ?? 10;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableDataSource extends DataTableSource {
  final List<DataRow> _rows;

  _TableDataSource(this._rows);

  @override
  DataRow? getRow(int index) => _rows[index];

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rows.length;

  @override
  int get selectedRowCount => 0;
}
