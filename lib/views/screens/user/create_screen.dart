import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/user/create_form_validation_controller.dart';
import 'package:oadminui/models/form_field.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_datepicker.dart';
import 'package:oadminui/views/widgets/oad_box_container.dart';
import 'package:oadminui/views/widgets/oad_button.dart';
import 'package:oadminui/views/widgets/oad_checkbox.dart';
import 'package:oadminui/views/widgets/oad_radio_group.dart';

class CreateNewScreen extends StatefulWidget {
  static const route = '/new-user';
  CreateNewScreen({Key? key}) : super(key: key);

  @override
  _CreateNewScreenState createState() => _CreateNewScreenState();
}

class _CreateNewScreenState extends State<CreateNewScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final List<OADFormField> fields = Get.arguments['fields'];
    final entity = Get.arguments['entity'];
    final indexRoute = Get.arguments['indexroute'];
    final controller = CreateFormController(entity: entity);
    return AppScaffold(
      pageTitle: 'New User',
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ...fields.map(
                  (field) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: getWidgetForField(field, controller),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      OADButton(
                        onPressed: () {
                          print(controller.entity);
                          Get.back();
                        },
                        title: 'Cancel',
                        isNegative: true,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      OADButton(
                        onPressed: () {
                          validateAndSave(controller, indexRoute);
                        },
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

  Widget getWidgetForField(
      OADFormField field, CreateFormController controller) {
    if (field.type == 'date') {
      return OADDatePickerFormField(
        labelText: 'Date of birth',
        onSaved: (value) =>
            controller.onSave(field.key, value?.millisecondsSinceEpoch),
      );
    } else if (field.type == 'boolean') {
      return OADBoxContainer(
        child: Column(
          children: [
            ...(field.values != null)
                ? field.values!.asMap().entries.map(
                      (entry) => OADCheckboxFormField(
                        title: entry.value,
                        onSaved: (value) =>
                            controller.onSave(field.keys![entry.key], value),
                      ),
                    )
                : []
          ],
        ),
        label: field.label,
      );
    } else if (field.type == 'enum') {
      return OADBoxContainer(
        label: field.label,
        child: OADRadioGroupFormField(
          values: field.values ?? [],
          onSaved: (value) => controller.onSave(field.key, value),
        ),
      );
    } else {
      return TextFormField(
        maxLength: field.length,
        validator: (value) => validator(value, field),
        onSaved: (value) => controller.onSave(field.key, value),
        decoration: InputDecoration(
          labelText: field.label,
          counterText: '',
        ),
      );
    }
  }

  String? validator(String? value, OADFormField field) {
    if (field.isRequired) {
      if (value == null || value.isEmpty) {
        return 'This field is required.';
      }
    }
    if (field.regex != null) {
      final regex = RegExp(field.regex!);
      if (!regex.hasMatch(value ?? '')) {
        return 'Invalid field value.';
      }
    }
    return null;
  }

  void validateAndSave(CreateFormController controller, String indexRoute) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      controller.create(
        () => {Get.offAndToNamed(indexRoute)},
      );
    }
  }
}
