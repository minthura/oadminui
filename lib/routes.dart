import 'package:flutter/material.dart';
import 'package:oadminui/controllers/user/data_controller.dart';
import 'package:oadminui/models/post.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/views/screens/login_screen.dart';
import 'package:oadminui/views/screens/user/create_screen.dart';
import 'package:oadminui/views/screens/user/index_screen.dart';
import 'package:oadminui/views/screens/user/update_screen.dart';
import 'views/screens/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.route: (_) => HomeScreen(),
  kRouteUsers: (_) => DataTableScreen<User>(
        instance: DataController<User>(User.entity),
        headers: User.headers,
        props: User.props,
        title: 'Users',
      ),
  kRoutePosts: (_) => DataTableScreen<Post>(
        instance: DataController<Post>(Post.entity),
        headers: Post.headers,
        props: Post.props,
        title: 'Posts',
      ),
  NewUserScreen.route: (_) => NewUserScreen(),
  UpdateUserScreen.route: (_) => UpdateUserScreen(),
  LoginScreen.route: (_) => LoginScreen(),
};

List<String> navMenuRoutes = [
  HomeScreen.route,
  kRouteUsers,
  kRoutePosts,
];

final kRouteUsers = '/users';
final kRoutePosts = '/posts';
