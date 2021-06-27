import 'package:get/get.dart';
import 'package:oadminui/views/screens/user/formz/email.dart';

class UserValidationController extends GetxController {
  final Rx<Email> email = Email.pure().obs;

  void onChange(String value) {
    email(Email.dirty(value));
  }

  String? onError() {
    if (email.value.pure) return null;
    return email.value.error?.name;
  }
}
