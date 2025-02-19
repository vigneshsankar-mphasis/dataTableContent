import 'package:flutter/material.dart';

class RadioOptionWidget extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String) onChanged;
  final Color circleColor; // Custom circle color

  const RadioOptionWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.circleColor = Colors.blue, // Default color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: (value) => onChanged(value!),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return circleColor; // Change circle color when selected
          }
          return Colors.grey; // Default unselected color
        }),
      ),
    );
  }
}
