import 'package:flutter/material.dart';
import 'package:oadminui/views/screens/user/create_screen.dart';
import 'package:oadminui/views/screens/user/index_screen.dart';
import 'views/screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.route: (_) => HomeScreen(),
  UsersScreen.route: (_) => UsersScreen(),
  NewUserScreen.route: (_) => NewUserScreen(),
};

List<String> navMenuRoutes = [
  HomeScreen.route,
  UsersScreen.route,
];
