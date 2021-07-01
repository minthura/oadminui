import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/session_controller.dart';
import 'package:oadminui/views/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = '/login';
  @override
  Widget build(BuildContext context) {
    SessionController _sessionController = Get.find();
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
                _sessionController
                    .login(() => Get.offAndToNamed(HomeScreen.route));
              },
              child: Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}
