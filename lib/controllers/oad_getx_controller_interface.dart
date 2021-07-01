import 'package:get/get.dart';
import 'package:oadminui/services/json_convertable.dart';

import 'base_controller.dart';

abstract class OADGetxControllerInterface<T> extends BaseGetxController {
  OADGetxControllerInterface(this.entityName, this.limit);
  void getData<T>(String entityName, int page, int limit);
  void delete(String id);
  int limit = 10;
  final totalEntities = 0.obs;
  final isBusy = false.obs;
  final RxList<OADEntity> entities = <OADEntity>[].obs;
  final String entityName;
}
