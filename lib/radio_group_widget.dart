import 'package:flutter/material.dart';

class RadioGroupWidget extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final Function(String) onChanged;
  final Color selectedColor; // Custom selected circle color
  final Color unselectedColor; // Custom unselected color

  const RadioGroupWidget({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.selectedColor = Colors.blue, // Default selected color
    this.unselectedColor = Colors.grey, // Default unselected color
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // To fit inside a column
      physics: NeverScrollableScrollPhysics(), // Prevent independent scrolling
      itemCount: options.length,
      itemBuilder: (context, index) {
        return RadioListTile<String>(
          title: Text(options[index], style: Theme.of(context).textTheme.bodyMedium),
          value: options[index],
          groupValue: selectedValue,
          onChanged: (value) => onChanged(value!),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return selectedColor; // Apply selected color
            }
            return unselectedColor; // Apply unselected color
          }),
        );
      },
    );
  }
}
