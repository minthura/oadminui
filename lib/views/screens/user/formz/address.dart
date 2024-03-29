import 'package:formz/formz.dart';

enum AddressValidationError { empty }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');
  const Address.dirty([String value = '']) : super.dirty(value);
  @override
  AddressValidationError? validator(String value) {
    if (value.isEmpty) {
      return AddressValidationError.empty;
    }
    return null;
  }
}

extension Explanation on AddressValidationError {
  String? get name {
    switch (this) {
      case AddressValidationError.empty:
        return "Address cannot be empty";
      default:
        return null;
    }
  }
}
