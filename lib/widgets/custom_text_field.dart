import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/customer_info_bloc.dart';
import '../blocs/customer_info_event.dart';
import '../blocs/customer_info_state.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String fieldKey;

  CustomTextField({required this.label, required this.fieldKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.fields[fieldKey] ?? '',
          decoration: InputDecoration(labelText: label),
          onChanged: (value) {
            context.read<CustomerInfoBloc>().add(UpdateField(fieldKey, value));
          },
        );
      },
    );
  }
}
