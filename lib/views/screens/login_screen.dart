import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/views/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Login Screen'),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(HomeScreen.route);
              },
              child: Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}
