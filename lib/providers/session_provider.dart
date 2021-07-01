import 'package:oadminui/http/http_client.dart';
import 'package:oadminui/http/http_error.dart';
import 'package:oadminui/models/session.dart';

class SessionProvider {
  static SessionProvider get instance => SessionProvider();
  login(Function(Session session) onSuccess, Function(HttpError) onError) {
    HttpClient.instance.get('login/1', (response) {
      var data = response.data;
      onSuccess(Session.fromJson(data));
    }, (e) {
      onError(e);
    });
  }
}
