import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/views/screens/home_screen.dart';
import 'package:oadminui/views/screens/users_screen.dart';

import 'app_route_observer.dart';
import 'routes.dart';
import 'theme.dart';

class OAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jobbie',
      theme: theme(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: UsersScreen.route,
      builder: EasyLoading.init(),
      navigatorObservers: [AppRouteObserver()],
      // home: ProductDetailScreen(), //BaseNavScreen(),
    );
  }
}
