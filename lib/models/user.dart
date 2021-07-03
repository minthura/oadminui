import 'package:intl/intl.dart';
import 'package:oadminui/services/json_convertable.dart';

class User extends OADEntity {
  static const entity = 'users';
  DateTime createdAt;
  String name;
  String email;
  String gender;
  String password;
  String address;
  int dob;
  bool canRead;
  bool canCreate;
  bool canUpdate;
  bool canDelete;
  String? userId;
  User({
    required this.createdAt,
    required this.name,
    required this.email,
    required this.gender,
    required this.password,
    required this.address,
    required this.dob,
    required this.canRead,
    required this.canCreate,
    required this.canUpdate,
    required this.canDelete,
    this.userId,
  }) : super(userId);

  set userGender(Gender gender) {
    if (gender == Gender.male) {
      this.gender = 'Male';
    } else {
      this.gender = 'Female';
    }
  }

  Gender get userGender {
    if (this.gender == 'Male') {
      return Gender.male;
    }
    return Gender.female;
  }

  User copy() {
    return User(
      createdAt: createdAt,
      name: name,
      email: email,
      gender: gender,
      password: password,
      address: address,
      dob: dob,
      canRead: canRead,
      canCreate: canCreate,
      canUpdate: canUpdate,
      canDelete: canDelete,
      userId: id,
    );
  }

  get dobStr {
    return DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(dob));
  }

  static User fromJson(dynamic json) {
    return User(
      createdAt: DateTime.parse(json["createdAt"]),
      name: json["name"],
      email: json["email"],
      gender: json["gender"],
      password: json["password"],
      address: json["address"],
      dob: json["dob"],
      canRead: json["canRead"],
      canCreate: json["canCreate"],
      canUpdate: json["canUpdate"],
      canDelete: json["canDelete"],
      userId: json["id"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "createdAt": createdAt.toIso8601String(),
      "name": name,
      "email": email,
      "gender": gender,
      "password": password,
      "address": address,
      "dob": dob,
      "canRead": canRead,
      "canCreate": canCreate,
      "canUpdate": canUpdate,
      "canDelete": canDelete,
      "id": id,
    };
  }

  static List<String> get headers => [
        'Name',
        'Email',
        'Gender',
      ];

  static List<String> get props => [
        'name',
        'email',
        'gender',
      ];
}

enum Gender { male, female }
