///
///
///
class Role {
  String name = '';

  ///
  ///
  ///
  Role.fromJson(final Map<String, dynamic> map) {
    name = map['name'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }
}
