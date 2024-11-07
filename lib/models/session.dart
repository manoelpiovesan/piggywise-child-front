import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Session {
  static final Session _instance = Session._internal();

  factory Session() {
    return _instance;
  }

  Session._internal();

  User? user;
}
