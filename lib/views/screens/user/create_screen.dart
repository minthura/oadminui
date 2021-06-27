import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/views/screens/user/user_validation_controller.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_datepicker.dart';
import 'package:oadminui/views/widgets/oad_radio_group.dart';

class NewUserScreen extends StatelessWidget {
  static const route = '/new-user';
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: 'New User',
      body: GetX<UserValidationController>(
        init: UserValidationController(),
        builder: (controller) => Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: controller.onChange,
                decoration: InputDecoration(
                    labelText: 'Email', errorText: controller.onError()),
              ),
              SizedBox(
                height: 16,
              ),
              MyDatePicker(
                labelText: 'Date of birth',
                onDateSelected: print,
              ),
              SizedBox(
                height: 16,
              ),
              RadioGroup(
                values: ['Male', 'Female'],
                onChanged: (index, value) => print("$index, $value"),
                label: 'Gender',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
