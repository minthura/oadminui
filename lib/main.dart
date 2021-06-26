import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'app.dart';

void main() {
  runApp(OAdminApp());
  configEasyLoading();
}

void configEasyLoading() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black26
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorWidget = CircularProgressIndicator(
      backgroundColor: Colors.red,
      valueColor: AlwaysStoppedAnimation(Colors.yellow),
    );
}
