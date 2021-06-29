import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/user/index_controller.dart';
import 'package:oadminui/views/screens/user/create_screen.dart';
import 'package:oadminui/views/screens/user/update_screen.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_paginated_table_v2.dart';

class UsersScreen extends StatelessWidget {
  static const route = '/users';
  const UsersScreen({Key? key}) : super(key: key);
  final limit = 10;
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
      body: GetX<UserIndexController>(
        init: UserIndexController(limit: limit),
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
              onActionEdit: (i) {
                Get.toNamed(UpdateUserScreen.route,
                    arguments: userController.users[i]);
              },
              onActionDelete: (i) async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete?'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Are you sure you want to delete?'),
                        Text('Name: ' + userController.users[i].name),
                        Text('Email: ' + userController.users[i].email),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          final idToDelete = userController.users[i].id;
                          if (idToDelete != null) {
                            userController.deleteUser(idToDelete);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              isBusy: userController.isBusy,
            ),
          ],
        ),
      ),
    );
  }
}
