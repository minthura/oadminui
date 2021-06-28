import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty, not_match }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  ConfirmPassword.pure(this.password) : super.pure('');
  ConfirmPassword.dirty(this.password, [String value = ''])
      : super.dirty(value);
  String password;
  @override
  ConfirmPasswordValidationError? validator(String value) {
    print("p2: $password, c2: $value");
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.empty;
    }
    if (value != password) {
      return ConfirmPasswordValidationError.not_match;
    }
    return null;
  }
}

extension Explanation on ConfirmPasswordValidationError {
  String? get name {
    switch (this) {
      case ConfirmPasswordValidationError.empty:
        return "Confirm password cannot be empty";
      case ConfirmPasswordValidationError.not_match:
        return "Passwords are not matched.";
      default:
        return null;
    }
  }
}
