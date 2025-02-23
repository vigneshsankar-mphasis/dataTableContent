import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("TextSpan Example")),
        body: Center(
          child: Container(
            width: 300, // Set a width to see multiline effect
            padding: EdgeInsets.all(10),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "This is a long text example using TextSpan. ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "It should be aligned properly and limited to a maximum of two lines.",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Show "..." if text overflows
              textAlign: TextAlign.start, // Change to center or right if needed
            ),
          ),
        ),
      ),
    );
  }
}
