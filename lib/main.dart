import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oadminui/http/http_client.dart';
import 'app.dart';

void main() {
  runApp(OAdminApp());
  configEasyLoading();
  HttpClient.initialize('https://60c9c2cb772a760017204576.mockapi.io/');
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
