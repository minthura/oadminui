import 'package:dio/dio.dart';
import 'base_service.dart';
import 'http_error.dart';

class HttpClient {
  static String _authToken = '';
  static Dio _dio = Dio();
  late final BaseService _baseService;
  static late HttpClient _httpClient;
  static HttpClient get instance => _httpClient;
  HttpClient() {
    this._baseService = BaseService();
  }

  static void initialize(String baseUrl) {
    _httpClient = HttpClient();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 5000
      ..options.receiveTimeout = 3000
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Do something before request is sent
            print('REQUEST[${options.method}] => PATH: ${options.path}');
            if (_authToken.isNotEmpty) {
              options.headers.putIfAbsent('Authorization', () => _authToken);
            }
            handler.next(options);
            //continue
            // If you want to resolve the request with some custom data，
            // you can return a `Response` object or return `dio.resolve(data)`.
            // If you want to reject the request with a error message,
            // you can return a `DioError` object or return `dio.reject(errMsg)`
          },
          onResponse: (response, handler) async {
            print(
                'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
            handler.next(response);
          },
          onError: (e, handler) async {
            // Do something with response error
            // print(e.message);
            // print(e.response.data);
            print(
                'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
            print('RESPONSE: ${e.response}');
            handler.next(e);
          },
        ),
      );
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  Future<void> get(String url, Function(Response<dynamic>) success,
      Function(HttpError) error) async {
    try {
      final Response resp = await _dio.get(url);
      success(resp);
    } catch (e) {
      _baseService.handleError(e, error);
    }
  }

  Future<void> post(String url, dynamic json,
      Function(Response<dynamic>) success, Function(HttpError) error) async {
    try {
      final Response resp = await _dio.post(url, data: json);
      success(resp);
    } catch (e) {
      _baseService.handleError(e, error);
    }
  }
}
