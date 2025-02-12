import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<Map<String, dynamic>> _rows = [];
  List<Map<String, dynamic>> _manualRows = [];
  int _rowsPerPage = 10;
  final List<int> _rowsPerPageOptions = [10, 20, 50, 100];
  int _currentPage = 0;
  int _totalRows = 0;
  bool _isAddingNewRow = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=$_rowsPerPage&skip=${_currentPage * _rowsPerPage}&select=title,price'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _totalRows = data['total'];
        _rows = (data['products'] as List).map((item) => {
          'title': item['title'],
          'price': item['price'],
          'isManual': false,
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _addNewRow() {
    setState(() {
      _isAddingNewRow = true;
    });
  }

  void _saveNewRow() {
    setState(() {
      _manualRows.add({
        'title': _titleController.text,
        'price': _priceController.text,
        'isManual': true,
      });
      _isAddingNewRow = false;
      _titleController.clear();
      _priceController.clear();
    });
  }

  void _deleteRow(int index) {
    setState(() {
      if (_manualRows.length > index) {
        _manualRows.removeAt(index);
      } else {
        _rows.removeAt(index - _manualRows.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paginated Table with API')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                header: Text('Financial Ratios - Remarks'),
                columns: [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Actions')),
                ],
                source: _TableDataSource([..._manualRows, ..._rows], _deleteRow),
                rowsPerPage: _rowsPerPage,
                availableRowsPerPage: _rowsPerPageOptions,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value ?? 10;
                    _fetchData();
                  });
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = (index ~/ _rowsPerPage);
                    _fetchData();
                  });
                },
              ),
            ),
          ),
          if (_isAddingNewRow)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title'))),
                  SizedBox(width: 10),
                  Expanded(child: TextField(controller: _priceController, decoration: InputDecoration(labelText: 'Price'))),
                  IconButton(icon: Icon(Icons.check), onPressed: _saveNewRow),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: _addNewRow,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _rows;
  final Function(int) _deleteRow;

  _TableDataSource(this._rows, this._deleteRow);

  @override
  DataRow? getRow(int index) {
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow(cells: [
      DataCell(Text(row['title'])),
      DataCell(Text('\$${row['price']}')),
      DataCell(IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteRow(index))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rows.length;

  @override
  int get selectedRowCount => 0;
}
