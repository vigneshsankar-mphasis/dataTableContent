import 'package:flutter_bloc/flutter_bloc.dart';
import 'customer_info_event.dart';
import 'customer_info_state.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  CustomerInfoBloc()
      : super(CustomerInfoState(fields: {
    'customerName': 'Ikhames Shieba',
    'industryDesc': 'Personal Customer',
    'country': 'Tanzania',
    'legalStatus': 'Elite-High Networth Individual',
    'dateOfEstablishment': '17/08/2005',
    'tlIssuingAuthority': 'DEPARTMENT OF ECONOMIC DEVELOPMENT, UMM AL',
    'tlExpiryDate': '16/5/2020',
    'tradeLicenceNo': '',
    'industrySICCode': '99106',
    'countryOfBusinessOperations': 'UNREGISTERED ENTITY',
    'countriesTradedWith': 'UNREGISTERED ENTITY',
    'cbdRelationshipStartDate': '24/3/1980',
    'borrowingRelationshipFrom': '02/1/2020',
  })) {
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, String>.from(state.fields)
        ..[event.field] = event.value;
      emit(state.copyWith(fields: updatedFields));
    });
  }
}
