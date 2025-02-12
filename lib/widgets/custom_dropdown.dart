import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/customer_info_bloc.dart';
import '../blocs/customer_info_event.dart';
import '../blocs/customer_info_state.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String fieldKey;
  final List<String> options;

  CustomDropdown({required this.label, required this.fieldKey, required this.options});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: state.fields[fieldKey],
          items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<CustomerInfoBloc>().add(UpdateField(fieldKey, value));
            }
          },
          decoration: InputDecoration(labelText: label),
        );
      },
    );
  }
}
