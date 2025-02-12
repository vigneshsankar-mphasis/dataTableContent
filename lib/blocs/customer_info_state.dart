class CustomerInfoState {
  final Map<String, String> fields;
  CustomerInfoState({required this.fields});

  CustomerInfoState copyWith({Map<String, String>? fields}) {
    return CustomerInfoState(fields: fields ?? this.fields);
  }
}
