import 'dart:convert';

import 'package:oadminui/services/json_convertable.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post extends OADEntity {
  static const entity = 'posts';

  Post({
    required this.createdAt,
    required this.title,
    required this.description,
    required this.author,
    required this.id,
  }) : super(id);

  DateTime createdAt;
  String title;
  String description;
  String author;
  String? id;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        createdAt: DateTime.parse(json["createdAt"]),
        title: json["title"],
        description: json["description"],
        author: json["author"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "title": title,
        "description": description,
        "author": author,
        "id": id,
      };

  static List<String> get headers => ['Title', 'Author', 'Created at'];

  static List<String> get props => [
        'title',
        'author',
        'createdAt',
      ];
}
