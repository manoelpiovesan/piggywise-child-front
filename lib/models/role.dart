///
///
///
class Role {
  String name = '';
  int id = -1;

  ///
  ///
  ///
  Role();

  ///
  ///
  ///
  Role.fromJson(final Map<String, dynamic> map) {
    name = map['name'];
    id = map['id'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }
}
