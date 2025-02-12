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
  String? _filterTitle;
  String? _filterPrice;
  List<String> _titleOptions = [];
  List<String> _priceOptions = [];

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
          'editable': false,
        }).toList();
        _titleOptions = _rows.map((e) => e['title'].toString()).toSet().toList();
        _priceOptions = _rows.map((e) => e['price'].toString()).toSet().toList();
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
      _manualRows.add({
        'title': '',
        'price': '',
        'isManual': true,
        'editable': true,
      });
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
      appBar: AppBar(title: Text('Paginated Table with Filters')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                header: Text('Financial Ratios - Remarks'),
                columns: [
                  DataColumn(
                    label: DropdownButton<String>(
                      hint: Text('Title'),
                      value: _filterTitle,
                      items: [null, ..._titleOptions].map((title) {
                        return DropdownMenuItem<String>(
                          value: title,
                          child: Text(title ?? 'All'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _filterTitle = value;
                        });
                      },
                    ),
                  ),
                  DataColumn(
                    label: DropdownButton<String>(
                      hint: Text('Price'),
                      value: _filterPrice,
                      items: [null, ..._priceOptions].map((price) {
                        return DropdownMenuItem<String>(
                          value: price,
                          child: Text(price ?? 'All'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _filterPrice = value;
                        });
                      },
                    ),
                  ),
                  DataColumn(label: Text('Actions')),
                ],
                source: _TableDataSource([..._manualRows, ..._rows], _deleteRow, _filterTitle, _filterPrice),
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
  final String? _filterTitle;
  final String? _filterPrice;

  _TableDataSource(this._rows, this._deleteRow, this._filterTitle, this._filterPrice);

  @override
  DataRow? getRow(int index) {
    if (index >= _rows.length) return null;
    final row = _rows[index];
    if ((_filterTitle != null && _filterTitle != row['title']) ||
        (_filterPrice != null && _filterPrice != row['price'].toString())) {
      return null;
    }
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