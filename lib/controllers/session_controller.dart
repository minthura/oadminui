import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/models/session.dart';
import 'package:oadminui/providers/session_provider.dart';

import 'base_controller.dart';

class SessionController extends BaseGetxController {
  final Rx<Session> session = Session(features: [], name: '', id: '').obs;
  login(Function onSuccess) async {
    EasyLoading.show(status: 'Logging in');
    SessionProvider.instance.login((s) {
      EasyLoading.dismiss();
      session(s);
      onSuccess();
    }, (e) {
      handleCommonError(e);
      EasyLoading.dismiss();
    });
  }
}
