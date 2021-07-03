class OADFormField {
  OADFormField({
    required this.label,
    required this.type,
    required this.isRequired,
    required this.length,
    required this.key,
    required this.id,
    this.regex,
    this.values,
    this.keys,
  });

  final String label;
  final String type;
  final bool isRequired;
  final int length;
  final String key;
  final List<String>? values;
  final List<String>? keys;
  final String? regex;
  final String id;

  factory OADFormField.fromJson(Map<String, dynamic> json) => OADFormField(
        label: json["label"],
        type: json["type"],
        isRequired: json["isRequired"],
        length: json["length"],
        key: json["key"],
        keys: json["keys"] == null
            ? null
            : List<String>.from(json["keys"].map((x) => x)),
        values: json["values"] == null
            ? null
            : List<String>.from(json["values"].map((x) => x)),
        regex: json["regex"] == null ? null : json["regex"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "type": type,
        "isRequired": isRequired,
        "length": length,
        "key": key,
        "keys": keys == null ? null : List<dynamic>.from(keys!.map((x) => x)),
        "values":
            values == null ? null : List<dynamic>.from(values!.map((x) => x)),
        "regex": regex == null ? null : regex,
        "id": id,
      };
}
