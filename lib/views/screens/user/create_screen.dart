import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/user/create_form_validation_controller.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_datepicker.dart';
import 'package:oadminui/views/widgets/oad_box_container.dart';
import 'package:oadminui/views/widgets/oad_button.dart';
import 'package:oadminui/views/widgets/oad_checkbox.dart';
import 'package:oadminui/views/widgets/oad_radio_group.dart';

class NewUserScreen extends StatelessWidget {
  static const route = '/new-user';
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserController userController = Get.put(UserController(), permanent: false);
    return AppScaffold(
      pageTitle: 'New User',
      body: GetX<UserCreateFormValidationController>(
        init: UserCreateFormValidationController(),
        global: false,
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: controller.onNameChanged,
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
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    errorText: controller.onConfirmPasswordError(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
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
                      ),
                      OADCheckbox(
                        label: 'WRITE',
                        onChanged: controller.canWrite,
                      ),
                      OADCheckbox(
                        label: 'UPDATE',
                        onChanged: controller.canUpdate,
                      ),
                      OADCheckbox(
                        label: 'DELETE',
                        onChanged: controller.canDelete,
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
                                controller.createUser();
                              }
                            : null,
                        title: 'CREATE',
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
