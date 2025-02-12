import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/customer_info_bloc.dart';
import '../blocs/customer_info_event.dart';
import '../blocs/customer_info_state.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final String fieldKey;

  CustomDatePicker({required this.label, required this.fieldKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.fields[fieldKey],
          decoration: InputDecoration(labelText: label),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              context.read<CustomerInfoBloc>().add(UpdateField(fieldKey, formattedDate));
            }
          },
        );
      },
    );
  }
}
