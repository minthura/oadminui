import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/user/update_controller.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_datepicker.dart';
import 'package:oadminui/views/widgets/oad_box_container.dart';
import 'package:oadminui/views/widgets/oad_button.dart';
import 'package:oadminui/views/widgets/oad_checkbox.dart';
import 'package:oadminui/views/widgets/oad_radio_group.dart';

class UpdateUserScreen extends StatefulWidget {
  static const route = '/update-user';
  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final dobTextEditingController = TextEditingController();
  User user = Get.arguments;
  @override
  void initState() {
    nameTextEditingController.text = user.name;
    emailTextEditingController.text = user.email;
    passwordTextEditingController.text = user.password;
    confirmTextEditingController.text = user.password;
    addressTextEditingController.text = user.address;
    dobTextEditingController.text = user.dobStr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: 'Update User',
      body: GetX<UserUpdateController>(
        init: UserUpdateController(user.obs),
        global: false,
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: controller.onNameChanged,
                  controller: nameTextEditingController,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    errorText: controller.onNameError(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: controller.onEmailChanged,
                  controller: emailTextEditingController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: controller.onEmailError(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: controller.onPasswordChanged,
                  controller: passwordTextEditingController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: controller.onPasswordError(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: controller.onConfirmPasswordChanged,
                  controller: confirmTextEditingController,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    errorText: controller.onConfirmPasswordError(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: addressTextEditingController,
                  onChanged: controller.onAddressChanged,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    errorText: controller.onAddressError(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                MyDatePicker(
                  labelText: 'Date of birth',
                  text: dobTextEditingController.text,
                  onDateSelected: (date) => controller.onDobChanged(date),
                  errorText: controller.onDobError(),
                ),
                SizedBox(
                  height: 8,
                ),
                OADBoxContainer(
                  label: 'Gender',
                  child: RadioGroup(
                    values: ['Male', 'Female'],
                    selectedValue: controller.user.value.gender,
                    onChanged: (index, value) =>
                        controller.onGenderChanged(index),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                OADBoxContainer(
                  child: Column(
                    children: [
                      OADCheckbox(
                        label: 'READ',
                        onChanged: controller.canRead,
                        isChecked: controller.canRead.value,
                      ),
                      OADCheckbox(
                        label: 'WRITE',
                        onChanged: controller.canWrite,
                        isChecked: controller.canWrite.value,
                      ),
                      OADCheckbox(
                        label: 'UPDATE',
                        onChanged: controller.canUpdate,
                        isChecked: controller.canUpdate.value,
                      ),
                      OADCheckbox(
                        label: 'DELETE',
                        onChanged: controller.canDelete,
                        isChecked: controller.canDelete.value,
                      ),
                    ],
                  ),
                  label: 'Access',
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      OADButton(
                        onPressed: () => Get.back(),
                        title: 'Cancel',
                        isNegative: true,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      OADButton(
                        onPressed: controller.isFormValid.value
                            ? () {
                                controller.updateUser();
                              }
                            : null,
                        title: 'Update',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
