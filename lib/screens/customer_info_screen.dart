import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/customer_info_bloc.dart';
import '../blocs/customer_info_event.dart';
import '../blocs/customer_info_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/section_title.dart';

class CustomerInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerInfoBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text("Customer Information")),
        drawer: SidebarMenu(),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: "Customer Information"),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(label: "Customer Name", fieldKey: "customerName")),
                        Expanded(child: CustomDropdown(label: "Country of Incorporation", fieldKey: "country", options: ["Tanzania", "Kenya", "Uganda"])),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(label: "Trade Licence No", fieldKey: "tradeLicenceNo")),
                        Expanded(child: CustomTextField(label: "Industry SIC Code", fieldKey: "industrySICCode")),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: CustomDropdown(label: "TL Issuing Authority", fieldKey: "tlIssuingAuthority", options: ["DEPARTMENT OF ECONOMIC DEVELOPMENT, UMM AL"])),
                        Expanded(child: CustomDatePicker(label: "TL Expiry Date", fieldKey: "tlExpiryDate")),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(label: "CBD Relationship Start Date", fieldKey: "cbdRelationshipStartDate")),
                        Expanded(child: CustomTextField(label: "Borrowing Relationship From", fieldKey: "borrowingRelationshipFrom")),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        print("Form Submitted: ${state.fields}");
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
