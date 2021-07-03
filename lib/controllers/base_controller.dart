import 'package:get/get.dart';
import 'package:oadminui/http/http_error.dart';
import 'package:oadminui/utils/oad_utils.dart';

class BaseGetxController extends GetxController {
  handleCommonError(HttpError e) {
    print(e.error);
    switch (e.error) {
      case ErrorType.CONNECTION_TIMEOUT:
        OADUtils.showErrorSnackbar(
            'Error', 'Please check your internet connection and try again.');
        break;
      case ErrorType.UNKNOWN:
        OADUtils.showErrorSnackbar('Error', 'Cannot connect to the server.');
        break;
      default:
        OADUtils.showErrorSnackbar('Error', 'An error has occurred.');
    }
  }
}
