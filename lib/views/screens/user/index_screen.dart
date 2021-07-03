import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oadminui/controllers/oad_getx_controller_interface.dart';
import 'package:oadminui/views/screens/user/create_screen.dart';
import 'package:oadminui/views/screens/user/update_screen.dart';
import 'package:oadminui/views/widgets/app_scaffold.dart';
import 'package:oadminui/views/widgets/my_paginated_table_v2.dart';

class DataTableScreen<T> extends StatelessWidget {
  const DataTableScreen({
    Key? key,
    required this.instance,
    required this.title,
    required this.route,
    required this.headers,
    required this.props,
  }) : super(key: key);
  final OADGetxControllerInterface instance;
  final String title;
  final String route;
  final List<String> headers;
  final List<String> props;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: title,
      actions: [
        IconButton(
            onPressed: () {
              instance.getFields(
                (fields) => Get.toNamed(CreateNewScreen.route, arguments: {
                  'fields': fields,
                  'entity': instance.entityName,
                  'indexroute': route,
                }),
              );
            },
            icon: Icon(CupertinoIcons.add))
      ],
      body: GetX<OADGetxControllerInterface>(
        init: instance,
        global: false,
        builder: (controller) => Stack(
          alignment: Alignment.center,
          children: [
            MyPaginatedDataTableV2(
              headers: headers,
              rowsPerPage: controller.limit,
              totalRows: controller.totalEntities.value,
              onPageChange: (p) => controller.getData<T>(
                  instance.entityName, p, controller.limit),
              rows: controller.entities,
              props: props,
              hasActions: true,
              onActionDetail: (i) => print(controller.entities[i]),
              onActionEdit: (i) {
                Get.toNamed(UpdateUserScreen.route,
                    arguments: controller.entities[i]);
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
                        Text('Name: ' +
                            controller.entities[i].toJson()[props[0]]),
                        Text('Email: ' +
                            controller.entities[i].toJson()[props[1]]),
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
                          final idToDelete = controller.entities[i].id;
                          if (idToDelete != null) {
                            instance.delete(controller.entityName, idToDelete);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              isBusy: controller.isBusy.value,
            ),
          ],
        ),
      ),
    );
  }
}
