import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/session_controller.dart';
import 'package:oadminui/controllers/user/data_controller.dart';
import 'package:oadminui/models/post.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/views/screens/home_screen.dart';
import 'package:oadminui/views/screens/login_screen.dart';
import 'package:oadminui/views/screens/user/index_screen.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'app_route_observer.dart';
import 'routes.dart';
import 'theme.dart';

class OAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<SessionController>(
      init: SessionController(),
      builder: (controller) => GetMaterialApp(
        title: 'Jobbie',
        theme: theme(),
        routes: getRoutes(controller),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.route,
        onUnknownRoute: (settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) => AppScaffold(
                pageTitle: 'Not found', body: Center(child: Text('Not Found'))),
          );
        },
        builder: EasyLoading.init(),
        navigatorObservers: [AppRouteObserver()],
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> getRoutes(
      SessionController controller) {
    final routes = {
      HomeScreen.route: (_) => HomeScreen(),
      LoginScreen.route: (_) => LoginScreen(),
    };
    navMenuRoutes.add(HomeScreen.route);
    controller.session.value.features.forEach((f) {
      navMenuRoutes.add(f.route);
      switch (f.entity) {
        case 'users':
          routes[f.route] = (_) => DataTableScreen<User>(
                instance: DataController<User>(User.entity),
                headers: User.headers,
                props: User.props,
                title: 'Users',
              );
          break;
        case 'posts':
          routes[f.route] = (_) => DataTableScreen<Post>(
                instance: DataController<Post>(Post.entity),
                headers: Post.headers,
                props: Post.props,
                title: 'Posts',
              );
          break;
        default:
      }
    });
    return routes;
  }
}
