import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oadminui/controllers/oad_getx_controller_interface.dart';
import 'package:oadminui/http/http_error.dart';
import 'package:oadminui/models/post.dart';
import 'package:oadminui/models/user.dart';
import 'package:oadminui/providers/crud_provider.dart';
import 'package:oadminui/services/json_convertable.dart';

class DataController<T> extends OADGetxControllerInterface {
  DataController(String entityName, {int limit = 10})
      : super(entityName, limit);
  @override
  void onInit() {
    super.onInit();
    getData<T>(entityName, 1, limit);
  }

  @override
  void delete(String entityName, String id) {
    EasyLoading.show(status: 'Deleting');
    CrudProvider.instance.deleteUser(entityName, id, () {
      entities.removeWhere((entity) => entity.id == id);
      totalEntities.value = totalEntities.value - 1;
      EasyLoading.dismiss();
    }, onError);
  }

  @override
  void getData<T>(String entityName, int page, int limit) {
    isBusy.value = true;
    EasyLoading.show(status: 'Loading');
    switch (T) {
      case User:
        CrudProvider.instance
            .getData<User>(entityName, page, limit, getDataOnSuccess, onError);
        break;
      case Post:
        CrudProvider.instance
            .getData<Post>(entityName, page, limit, getDataOnSuccess, onError);
        break;
      default:
        EasyLoading.dismiss();
        isBusy.value = false;
        break;
    }
  }

  getDataOnSuccess(List<OADEntity> items, int count) {
    entities(items);
    totalEntities(count);
    EasyLoading.dismiss();
    isBusy.value = false;
  }

  onError(HttpError e) {
    handleCommonError(e);
    EasyLoading.dismiss();
    isBusy.value = false;
  }

  @override
  set limit(int _limit) {
    this.limit = _limit;
  }

  @override
  int get limit => 10;
}
