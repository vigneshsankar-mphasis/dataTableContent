import 'package:flutter/material.dart';
import 'radio_option_widget.dart';
import 'radio_group_widget.dart';

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
      home: RadioSelectionScreen(),
    );
  }
}

class RadioSelectionScreen extends StatefulWidget {
  @override
  _RadioSelectionScreenState createState() => _RadioSelectionScreenState();
}

class _RadioSelectionScreenState extends State<RadioSelectionScreen> {
  String selectedValueA = 'Option 1'; // Selection for Option A
  String selectedValueB = 'Option 1'; // Selection for Option B
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Selection'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Option A: Single Select Radio Buttons ===
            Text('Option A - Single Select:', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 10),
            Column(
              children: options
                  .map((option) => RadioOptionWidget(
                title: option,
                value: option,
                groupValue: selectedValueA,
                circleColor: _getCircleColor(option),
                onChanged: (value) {
                  setState(() {
                    selectedValueA = value;
                  });
                },
              ))
                  .toList(),
            ),

            SizedBox(height: 10),
            Text('Selected in Option A: $selectedValueA', style: Theme.of(context).textTheme.bodyMedium),

            SizedBox(height: 20),

            // === Option B: ListView Radio Buttons ===
            Text('Option B - ListView Select:', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 10),
            RadioGroupWidget(
              options: options,
              selectedValue: selectedValueB,
              selectedColor: Colors.green,
              unselectedColor: Colors.red,
              onChanged: (value) {
                setState(() {
                  selectedValueB = value;
                });
              },
            ),

            SizedBox(height: 10),
            Text('Selected in Option B: $selectedValueB', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  // Custom function to assign colors to each option
  Color _getCircleColor(String option) {
    switch (option) {
      case 'Option 1':
        return Colors.green;
      case 'Option 2':
        return Colors.red;
      case 'Option 3':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}
