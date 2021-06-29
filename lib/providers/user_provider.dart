import 'package:oadminui/http/http_client.dart';
import 'package:oadminui/http/http_error.dart';
import 'package:oadminui/models/user.dart';

class UserProvider {
  static UserProvider get instance => UserProvider();
  getUsers(int page, int limit, Function(List<User> users, int count) onSuccess,
      Function(HttpError) onError) {
    HttpClient.instance.get('users?page=$page&limit=$limit', (response) {
      var data = response.data;
      var users = List<User>.from(data['users'].map((x) => User.fromJson(x)));
      onSuccess(users, data['count']);
    }, (e) {
      onError(e);
    });
  }

  createUser(
      User user, Function(User user) onSuccess, Function(HttpError) onError) {
    HttpClient.instance.post('users', user.toJson(), (response) {
      var data = response.data;
      onSuccess(User.fromJson(data));
    }, (e) {
      onError(e);
    });
  }

  updateUser(
      User user, Function(User user) onSuccess, Function(HttpError) onError) {
    HttpClient.instance.put('users/${user.id}', user.toJson(), (response) {
      var data = response.data;
      onSuccess(User.fromJson(data));
    }, (e) {
      onError(e);
    });
  }

  deleteUser(String id, Function() onSuccess, Function(HttpError) onError) {
    HttpClient.instance.delete('users/$id', (response) {
      onSuccess();
    }, (e) {
      onError(e);
    });
  }
}
