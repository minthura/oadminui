import 'package:oadminui/services/json_convertable.dart';

class User extends JsonConvertable {
  final String userID;
  final String name;
  final String role;
  User({required this.userID, required this.name, required this.role});

  static User fromJson(dynamic json) {
    return User(
      userID: json['userID'] == null ? 'x' : json['userID'],
      name: json['name'] == null ? "Unknown" : json['name'],
      role: json['role'] == null ? "Unknown" : json['role'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "role": role,
      "userID": userID,
    };
  }
}
