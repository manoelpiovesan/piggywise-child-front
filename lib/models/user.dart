import 'package:piggywise_child_front/enums/profile_type.dart';

///
///
///
class User {
  String username = '';
  String password = '';
  String role = '';
  ProfileType profileType = ProfileType.child;

  ///
  ///
  ///
  User();

  ///
  ///
  ///
  User.fromJson(final Map<String, dynamic> map) {
    username = map['username'];
    role = map['role'];
    profileType = ProfileType.fromString(map['profileType']);
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'role': role,
      'profileType': profileType.name.toLowerCase(),
    };
  }
}
