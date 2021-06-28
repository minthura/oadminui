import 'package:flutter/material.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: 'Home',
      body: Center(
        child: Text('This is the home page'),
      ),
    );
  }
}
