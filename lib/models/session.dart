import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/login_view.dart';

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

  static Future<void> logout(final BuildContext context) =>
      Utils.navReplace(context, LoginView());
}
