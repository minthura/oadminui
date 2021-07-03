import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/base_controller.dart';
import 'package:oadminui/providers/crud_provider.dart';
import 'package:oadminui/utils/oad_utils.dart';

class CreateFormController extends BaseGetxController {
  CreateFormController({required this.entity});
  final String entity;
  final RxMap<String, dynamic> jsonMap = Map<String, dynamic>().obs;
  onSave(String key, dynamic value) {
    jsonMap[key] = value;
  }

  create(Function onSuccess) {
    EasyLoading.show(status: 'Creating');
    CrudProvider.instance.create(entity, jsonMap, () {
      onSuccess();
      EasyLoading.dismiss();
      OADUtils.showSuccessSnackbar('Created', 'Successfully created.');
    }, (e) {
      handleCommonError(e);
      EasyLoading.dismiss();
    });
  }
}
