import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/providers/user_provider.dart';

import 'base_controller.dart';

class UserController extends BaseGetxController {
  final RxList<User> users = <User>[].obs;
  final totalUsers = 0.obs;
  final _isBusy = false.obs;
  final int limit;

  UserController({this.limit = 10});

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

  void createUser(User user, Function(User) onSuccess) {
    _isBusy.value = true;
    EasyLoading.show(status: 'Loading');
    UserProvider.instance.createUser(user, (response) {
      EasyLoading.dismiss();
      _isBusy.value = false;
      onSuccess(response);
    }, (error) {
      handleCommonError(error);
      EasyLoading.dismiss();
      _isBusy.value = false;
    });
  }

  bool get isBusy => _isBusy.value;

  @override
  void onInit() {
    super.onInit();
    getUsers(1, limit);
  }
}
