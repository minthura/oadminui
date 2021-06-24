import 'package:flutter/material.dart';
import 'package:oadminui/views/screens/users_screen.dart';
import 'views/screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.route: (_) => HomeScreen(),
  UsersScreen.route: (_) => UsersScreen(),
};
