import 'package:formz/formz.dart';

enum DateOfBirthValidationError { empty, invalid }

class DateOfBirth extends FormzInput<DateTime, DateOfBirthValidationError> {
  DateOfBirth.pure() : super.pure(DateTime(2000));
  DateOfBirth.dirty([String value = '']) : super.dirty(DateTime.parse(value));

  @override
  DateOfBirthValidationError? validator(DateTime value) {
    if (this.pure) {
      return DateOfBirthValidationError.empty;
    }
    if (value.isAfter(DateTime.now())) {
      return DateOfBirthValidationError.invalid;
    }
    return null;
  }
}

extension Explanation on DateOfBirthValidationError {
  String? get name {
    switch (this) {
      case DateOfBirthValidationError.empty:
        return "Date of birth cannot be empty.";
      case DateOfBirthValidationError.invalid:
        return "Date of birth cannot be in the future.";
      default:
        return null;
    }
  }
}
