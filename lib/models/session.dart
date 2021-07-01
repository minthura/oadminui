import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  Session({
    required this.features,
    required this.name,
    required this.id,
  });

  List<Feature> features;
  String name;
  String id;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "name": name,
        "id": id,
      };
}

class Feature {
  Feature({
    required this.entity,
    required this.title,
    required this.id,
  });

  String entity;
  String title;
  String id;

  get route {
    return '/$entity';
  }

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        entity: json["entity"],
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "entity": entity,
        "title": title,
        "id": id,
      };
}
