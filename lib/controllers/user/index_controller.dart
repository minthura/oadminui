import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/providers/user_provider.dart';

import '../base_controller.dart';

class UserIndexController extends BaseGetxController {
  final RxList<User> users = <User>[].obs;
  final totalUsers = 0.obs;
  final _isBusy = false.obs;
  final int limit;

  UserIndexController({this.limit = 10});

  void getUsers(int page, int limit) {
    _isBusy.value = true;
    EasyLoading.show(status: 'Loading');
    UserProvider.instance.getUsers(page, limit, (data, count) {
      users(data);
      totalUsers(count);
      EasyLoading.dismiss();
      _isBusy.value = false;
    }, (error) {
      handleCommonError(error);
      EasyLoading.dismiss();
      _isBusy.value = false;
    });
  }

  void deleteUser(String id) {
    EasyLoading.show(status: 'Deleting');
    UserProvider.instance.deleteUser(id, () {
      users.removeWhere((user) => user.id == id);
      totalUsers.value = totalUsers.value - 1;
      EasyLoading.dismiss();
    }, (error) {
      handleCommonError(error);
      EasyLoading.dismiss();
    });
  }

  bool get isBusy => _isBusy.value;

  @override
  void onInit() {
    super.onInit();
    getUsers(1, limit);
  }
}
