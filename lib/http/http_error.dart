import 'package:dio/dio.dart';

enum ErrorType {
  CONNECTION_TIMEOUT,
  BAD_REQUEST, //400
  UNAUTHORIZED, //401
  FORBIDDEN, //403
  NOT_FOUND, //404
  INTERNAL_SERVER_ERROR, //500
  SERVICE_UNAVAILABLE, // 503
  CANCEL,
  CLIENT_ERROR,
  SERVER_ERROR,
  UNKNOWN,
}

class HttpError {
  ErrorType _type = ErrorType.UNKNOWN;
  DioError dioError;
  HttpError({required this.dioError}) {
    switch (dioError.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
        this._type = ErrorType.CONNECTION_TIMEOUT;
        break;
      case DioErrorType.response:
        final response = dioError.response;
        if (response != null) {
          switch (response.statusCode) {
            case 400:
              this._type = ErrorType.BAD_REQUEST;
              break;
            case 401:
              this._type = ErrorType.UNAUTHORIZED;
              break;
            case 403:
              this._type = ErrorType.FORBIDDEN;
              break;
            case 404:
              this._type = ErrorType.NOT_FOUND;
              break;
            case 500:
              this._type = ErrorType.INTERNAL_SERVER_ERROR;
              break;
            case 503:
              this._type = ErrorType.SERVICE_UNAVAILABLE;
              break;
            default:
              if (response.statusCode != null) {
                if (response.statusCode! >= 400 &&
                    response.statusCode! <= 499) {
                  this._type = ErrorType.CLIENT_ERROR;
                } else if (response.statusCode! >= 500 &&
                    response.statusCode! <= 599) {
                  this._type = ErrorType.SERVER_ERROR;
                } else {
                  this._type = ErrorType.UNKNOWN;
                }
              } else {
                this._type = ErrorType.UNKNOWN;
              }
              break;
          }
        }
        break;
      case DioErrorType.cancel:
        this._type = ErrorType.CANCEL;
        break;
      default:
        this._type = ErrorType.UNKNOWN;
        break;
    }
  }

  ErrorType get error {
    return _type;
  }

  String get responseBody {
    return dioError.response.toString();
  }

  Response<dynamic>? get response {
    return dioError.response;
  }
}
