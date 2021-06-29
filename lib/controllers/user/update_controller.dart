import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/base_controller.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/providers/user_provider.dart';
import 'package:oadminui/views/screens/user/formz/address.dart';
import 'package:oadminui/views/screens/user/formz/confirm_password.dart';
import 'package:oadminui/views/screens/user/formz/dob.dart';
import 'package:oadminui/views/screens/user/formz/email.dart';
import 'package:oadminui/views/screens/user/formz/name.dart';
import 'package:oadminui/views/screens/user/formz/password.dart';
import 'package:oadminui/views/screens/user/index_screen.dart';

class UserUpdateController extends BaseGetxController {
  Rx<Name> name = Name.pure().obs;
  Rx<Email> email = Email.pure().obs;
  Rx<Password> password = Password.pure().obs;
  Rx<Address> address = Address.pure().obs;
  Rx<ConfirmPassword> confirmPassword = ConfirmPassword.pure('').obs;
  Rx<DateOfBirth> dob = DateOfBirth.pure().obs;
  Rx<Gender> gender = Gender.male.obs;
  final isFormValid = false.obs;
  var canRead = false.obs;
  var canWrite = false.obs;
  var canUpdate = false.obs;
  var canDelete = false.obs;
  final Rx<User> user;

  UserUpdateController(this.user) {
    name = Name.dirty(user.value.name).obs;
    email = Email.dirty(user.value.email).obs;
    password = Password.dirty(user.value.password).obs;
    address = Address.dirty(user.value.address).obs;
    confirmPassword =
        ConfirmPassword.dirty(user.value.password, user.value.password).obs;
    dob = DateOfBirth.dirty(
            DateTime.fromMillisecondsSinceEpoch(user.value.dob).toString())
        .obs;
    gender = user.value.userGender.obs;
    canRead = user.value.canRead.obs;
    canWrite = user.value.canWrite.obs;
    canUpdate = user.value.canUpdate.obs;
    canDelete = user.value.canDelete.obs;
    validate();
  }

  void onNameChanged(String value) {
    name(Name.dirty(value));
    validate();
  }

  void onEmailChanged(String value) {
    email(Email.dirty(value));
    validate();
  }

  void onPasswordChanged(String value) {
    password(Password.dirty(value));
    onConfirmPasswordChanged(confirmPassword.value.value);
    validate();
  }

  void onConfirmPasswordChanged(String value) {
    confirmPassword.value.password = password.value.value;
    confirmPassword(ConfirmPassword.dirty(password.value.value, value));
    validate();
  }

  void onDobChanged(DateTime value) {
    dob(DateOfBirth.dirty(value.toString()));
    validate();
  }

  void onAddressChanged(String value) {
    address(Address.dirty(value));
    validate();
  }

  void onGenderChanged(int index) {
    gender(index == 0 ? Gender.male : Gender.female);
    validate();
  }

  void canReadChanged(bool can) {
    canRead(can);
    validate();
  }

  void canWriteChanged(bool can) {
    canWrite(can);
    validate();
  }

  void canUpdateChanged(bool can) {
    canUpdate(can);
    validate();
  }

  void canDeleteChanged(bool can) {
    canDelete(can);
    validate();
  }

  bool validate() {
    final inputs = <FormzInput>[
      name.value,
      email.value,
      password.value,
      confirmPassword.value,
      address.value,
      dob.value
    ];
    var status = Formz.validate(inputs);
    print(status);
    if (status == FormzStatus.pure || status == FormzStatus.invalid) {
      isFormValid(false);
      return false;
    } else {
      isFormValid(true);
      return true;
    }
  }

  void updateUser() {
    if (validate()) {
      EasyLoading.show(status: 'Updating');
      final user = User(
        id: this.user.value.id,
        createdAt: DateTime.now(),
        name: name.value.value,
        email: email.value.value,
        gender: gender.value == Gender.male ? 'Male' : 'Female',
        password: password.value.value,
        address: address.value.value,
        dob: dob.value.value.millisecondsSinceEpoch,
        canRead: canRead.value,
        canWrite: canWrite.value,
        canUpdate: canUpdate.value,
        canDelete: canDelete.value,
      );
      UserProvider.instance.updateUser(user, (response) {
        EasyLoading.dismiss();
        Get.offAndToNamed(UsersScreen.route);
      }, (error) {
        handleCommonError(error);
        EasyLoading.dismiss();
      });
    }
  }

  String? onNameError() {
    if (name.value.pure) return null;
    return name.value.error?.name;
  }

  String? onEmailError() {
    if (email.value.pure) return null;
    return email.value.error?.name;
  }

  String? onPasswordError() {
    if (password.value.pure) return null;
    return password.value.error?.name;
  }

  String? onConfirmPasswordError() {
    if (confirmPassword.value.pure) return null;
    return confirmPassword.value.error?.name;
  }

  String? onDobError() {
    if (dob.value.pure) return null;
    return dob.value.error?.name;
  }

  String? onAddressError() {
    if (address.value.pure) return null;
    return address.value.error?.name;
  }
}
