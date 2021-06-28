import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/user_controller.dart';
import 'package:oadminui/views/screens/user/create_screen.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_paginated_table_v2.dart';

class UsersScreen extends StatelessWidget {
  static const route = '/users';
  const UsersScreen({Key? key}) : super(key: key);
  final limit = 5;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: 'Users',
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(NewUserScreen.route);
            },
            icon: Icon(CupertinoIcons.add))
      ],
      body: GetX<UserController>(
        init: UserController(limit: limit),
        global: false,
        builder: (userController) => Stack(
          alignment: Alignment.center,
          children: [
            MyPaginatedDataTableV2(
              headers: [
                'Name',
                'Email',
                'Gender',
              ],
              rowsPerPage: limit,
              totalRows: userController.totalUsers.value,
              onPageChange: (p) => userController.getUsers(p, limit),
              rows: userController.users,
              props: [
                'name',
                'email',
                'gender',
              ],
              hasActions: true,
              onActionDetail: (i) => print(userController.users[i].name),
              onActionEdit: (i) => print(userController.users[i].name),
              onActionDelete: (i) => print(userController.users[i].id),
              isBusy: userController.isBusy,
            ),
          ],
        ),
      ),
    );
  }
}
