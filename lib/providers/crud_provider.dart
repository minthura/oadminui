import 'package:oadminui/http/http_client.dart';
import 'package:oadminui/http/http_error.dart';
import 'package:oadminui/models/post.dart';
import 'package:oadminui/models/user.dart';

class CrudProvider {
  static CrudProvider get instance => CrudProvider();
  getData<T>(
    String entityName,
    int page,
    int limit,
    Function(List<T> users, int count) onSuccess,
    Function(HttpError) onError,
  ) {
    HttpClient.instance.get('$entityName?page=$page&limit=$limit', (response) {
      var data = response.data;
      var users = List<T>.from(data[entityName].map((x) => fromJson<T>(x)));
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

  // Changed/Add entities here
  fromJson<T>(json) {
    switch (T) {
      case User:
        return User.fromJson(json);
      case Post:
        return Post.fromJson(json);
      default:
    }
  }
}
