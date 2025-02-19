import 'package:flutter/material.dart';
import 'radio_group_widget.dart'; // Import the reusable radio group component

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.light(
          primary: Colors.green, // Selected circle color
          secondary: Colors.orange,
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w500),
        ),
      ),
      home: RadioGroupExample(),
    );
  }
}

class RadioGroupExample extends StatefulWidget {
  @override
  _RadioGroupExampleState createState() => _RadioGroupExampleState();
}

class _RadioGroupExampleState extends State<RadioGroupExample> {
  String selectedValue = 'Option 1';
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Group Example'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select an Option:', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 10),
            RadioGroupWidget(
              options: options,
              selectedValue: selectedValue,
              selectedColor: Colors.green, // Change selected circle color
              unselectedColor: Colors.red, // Change unselected circle color
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Selected: $selectedValue', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
