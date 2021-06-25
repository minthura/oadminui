import 'package:oadminui/services/json_convertable.dart';

class User extends JsonConvertable {
  final String userID;
  final String name;
  final String role;
  final String avatar;
  final String email;
  final String gender;
  User(
      {required this.avatar,
      required this.email,
      required this.gender,
      required this.userID,
      required this.name,
      required this.role});

  static User fromJson(dynamic json) {
    return User(
      userID: json['userID'] == null ? "" : json['userID'],
      name: json['name'] == null ? "" : json['name'],
      role: json['role'] == null ? "" : json['role'],
      avatar: json['avatar'] == null ? "" : json['avatar'],
      email: json['email'] == null ? "" : json['email'],
      gender: json['gender'] == null ? "" : json['gender'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "role": role,
      "userID": userID,
      "avatar": avatar,
      "email": email,
      "gender": gender,
    };
  }
}
