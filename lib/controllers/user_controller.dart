import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/models/user.dart';

class UserController extends GetxController {
  final RxList<User> users = <User>[].obs;
  final _isLoading = false.obs;
  final int limit;

  UserController({required this.limit});

  Future<List<User>> getUsers(int page, int limit) async {
    _isLoading.value = true;
    EasyLoading.show(status: 'Loading');
    final dio = Dio();
    try {
      var response = await dio.get(
          'https://60c9c2cb772a760017204576.mockapi.io/users?page=$page&limit=$limit');
      var data = response.data;
      var _users = List<User>.from(data.map((x) => User.fromJson(x)));
      users(_users);
      _isLoading.value = false;
      EasyLoading.dismiss();
      return _users;
    } catch (e) {
      print(e);
      _isLoading.value = false;
    }
    EasyLoading.dismiss();
    return [];
  }

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getUsers(1, limit);
  }
}
