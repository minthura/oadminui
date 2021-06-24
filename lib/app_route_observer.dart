import 'package:flutter/material.dart';

class AppRouteObserver extends RouteObserver<ModalRoute<void>> {
  factory AppRouteObserver() => _instance;

  AppRouteObserver._private();

  static final AppRouteObserver _instance = AppRouteObserver._private();
}
