import 'package:flutter/material.dart';
import 'radio_option_widget.dart'; // Import the custom radio component

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
          children: [
            Text('Choose an option:', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 10),
            RadioOptionWidget(
              title: 'Option 1',
              value: 'Option 1',
              groupValue: selectedValue,
              circleColor: Colors.green, // Custom color
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            RadioOptionWidget(
              title: 'Option 2',
              value: 'Option 2',
              groupValue: selectedValue,
              circleColor: Colors.red, // Custom color
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            RadioOptionWidget(
              title: 'Option 3',
              value: 'Option 3',
              groupValue: selectedValue,
              circleColor: Colors.purple, // Custom color
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
