import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oadminui/views/screens/home_screen.dart';
import 'package:oadminui/views/screens/user/create_screen.dart';
import 'package:oadminui/views/screens/user/index_screen.dart';

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
      initialRoute: NewUserScreen.route,
      builder: EasyLoading.init(),
      navigatorObservers: [AppRouteObserver()],
      // home: ProductDetailScreen(), //BaseNavScreen(),
    );
  }
}
