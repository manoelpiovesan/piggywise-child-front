import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/models/role.dart';

///
///
///
class User {
  String username = '';
  String password = '';
  String name = '';
  List<Role> roles = <Role>[];
  Family? family;

  ///
  ///
  ///
  User();

  ///
  ///
  ///
  User.fromJson(final Map<String, dynamic> map) {
    username = map['username'] ?? '';
    name = map['name'] ?? '';
    if (map['roles'] != null) {
      for (final Map<String, dynamic> role in map['roles']) {
        roles.add(Role.fromJson(role));
      }
    }
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'name': name,
      'roles': roles.map((final Role role) => role.toMap()).toList(),
      'family': family?.toMap(),
    };
  }

  ///
  ///
  ///
  bool get isParent {
    for (final Role role in roles) {
      if (role.name == 'parent') {
        return true;
      }
    }
    return false;
  }
}
