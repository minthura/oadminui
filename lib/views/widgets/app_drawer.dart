import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/routes.dart';
import 'package:oadminui/views/screens/home_screen.dart';

import '../../app_route_observer.dart';

/// The navigation drawer for the app.
/// This listens to changes in the route to update which page is currently been shown
class AppDrawer extends StatefulWidget {
  const AppDrawer({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {
  static String _selectedRoute = '/';
  AppRouteObserver? _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver?.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _updateSelectedRoute();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Row(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    accountName: Text('User'),
                    accountEmail: Text('user@email.com'),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.android),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () async {
                      await _navigateTo(context, HomeScreen.route);
                    },
                    selected: _selectedRoute == HomeScreen.route,
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Users'),
                    onTap: () async {
                      await _navigateTo(context, kRouteUsers);
                    },
                    selected: _selectedRoute == kRouteUsers,
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Posts'),
                    onTap: () async {
                      await _navigateTo(context, kRoutePosts);
                    },
                    selected: _selectedRoute == kRoutePosts,
                  ),
                ],
              ),
            ),
            if (widget.permanentlyDisplay)
              const VerticalDivider(
                width: 1,
              )
          ],
        ),
      ),
    );
  }

  /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
  /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
  }

  void _updateSelectedRoute() {
    if (navMenuRoutes.contains(Get.currentRoute)) {
      setState(() {
        _selectedRoute = Get.currentRoute;
      });
    }
  }
}
