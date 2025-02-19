import 'package:flutter/material.dart';

class RadioSelectionWidget extends StatelessWidget {
  final List<String>? options; // Null means it's a single option
  final String selectedValue;
  final Function(String) onChanged;
  final Color selectedColor; // Custom selected circle color
  final Color unselectedColor; // Custom unselected circle color
  final String? title; // For single option usage

  const RadioSelectionWidget({
    super.key,
    this.options,
    required this.selectedValue,
    required this.onChanged,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (options != null && options!.isNotEmpty) {
      // Grouped Radio List
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: options!.length,
        itemBuilder: (context, index) {
          return _buildRadioTile(options![index]);
        },
      );
    } else {
      // Single Radio Option
      return _buildRadioTile(title ?? "Option");
    }
  }

  Widget _buildRadioTile(String optionTitle) {
    return ListTile(
      title: Text(optionTitle, style: TextStyle(fontSize: 16.0)),
      leading: Radio<String>(
        value: optionTitle,
        groupValue: selectedValue,
        onChanged: (value) {
          try {
            if (value != null) {
              onChanged(value);
            }
          } catch (e, stackTrace) {
            debugPrint("Error in RadioSelectionWidget: $e");
            debugPrintStack(stackTrace: stackTrace);
          }
        },
        fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            return states.contains(WidgetState.selected) ? selectedColor : unselectedColor;
          },
        ),
      ),
    );
  }
}
