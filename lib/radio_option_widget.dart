import 'package:flutter/material.dart';

class RadioOptionWidget extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String) onChanged;
  final Color circleColor; // Custom circle color

  const RadioOptionWidget({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.circleColor = Colors.blue, // Default color
  });

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
        onChanged: (newValue) {
          try {
            if (newValue != null) {
              onChanged(newValue);
            }
          } catch (e, stackTrace) {
            debugPrint("Error in RadioOptionWidget: $e");
            debugPrintStack(stackTrace: stackTrace);
          }
        },
        fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return circleColor; // Custom selected color
            }
            return Colors.grey; // Default unselected color
          },
        ),
      ),
    );
  }
}
