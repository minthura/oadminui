abstract class OADEntity {
  Map<String, dynamic> toJson();
  String? id;
  OADEntity(this.id);
  @override
  String toString() {
    return this.toJson().toString();
  }
}
