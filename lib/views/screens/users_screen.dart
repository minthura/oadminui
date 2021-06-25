import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/user_controller.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_paginated_table.dart';

class UsersScreen extends StatelessWidget {
  static const route = '/users';
  const UsersScreen({Key? key}) : super(key: key);
  final limit = 10;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: 'Users',
      actions: [IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))],
      body: GetX<UserController>(
        init: UserController(limit: limit),
        global: false,
        builder: (userController) => Stack(
          alignment: Alignment.center,
          children: [
            MyPaginatedDataTable(
              headers: ['Name', 'Role', 'Email', 'Gender'],
              rowsPerPage: limit,
              totalRows: 30,
              onPageChange: (p) => userController.getUsers(p, limit),
              rows: userController.users,
              props: ['name', 'role', 'email', 'gender'],
              hasActions: true,
              onActionDetail: (i) => print(userController.users[i].name),
              onActionEdit: (i) => print(userController.users[i].name),
              onActionDelete: (i) => print(userController.users[i].name),
              isBusy: userController.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
