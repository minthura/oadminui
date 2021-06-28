import 'package:dio/dio.dart';

import 'http_error.dart';

class BaseService {
  void handleError(dynamic e, Function(HttpError) callback) {
    if (e is DioError) {
      callback(HttpError(dioError: e));
    } else {
      callback(HttpError(
          dioError: DioError(
              requestOptions: e.requestOptions, type: DioErrorType.other)));
    }
  }
}
