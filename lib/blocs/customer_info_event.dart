abstract class CustomerInfoEvent {}

class UpdateField extends CustomerInfoEvent {
  final String field;
  final String value;
  UpdateField(this.field, this.value);
}
