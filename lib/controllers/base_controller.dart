import 'package:get/get.dart';
import 'package:oadminui/http/http_error.dart';
import 'package:oadminui/utils/oad_utils.dart';

class BaseGetxController extends GetxController {
  handleCommonError(HttpError e) {
    OADUtils.showSnackbar('Error', 'An error has occurred.');
  }
}
