import 'dart:convert';

import 'package:agattp/agattp.dart';
import 'package:flutter/foundation.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/config.dart';

///
///
///
class UserConsumer {
  ///
  ///
  ///
  Future<User> login(final User user) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(username: user.username, password: user.password)
            .getJson(
      Uri.parse(<String>[Config().backUrl, 'user', 'login'].join('/')),
    );

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha no Login');
    }

    Session().user = User.fromJson(response.json);
    Session().user!.password = user.password;

    return User.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<User> createChild(final User user) async {
    final AgattpResponse response = await Agattp().post(
      Uri.parse(
        <String>[Config().backUrl, 'user', 'create', 'child'].join('/'),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toMap()),
    );

    if (kDebugMode) {
      print('Response: ${response.body}');
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Failed to create child');
    }

    return User.fromJson(jsonDecode(response.body));
  }

  ///
  ///
  ///
  Future<User> createParent(final User user) async {
    final AgattpResponse response = await Agattp().post(
      Uri.parse(
        <String>[Config().backUrl, 'user', 'create', 'parent'].join('/'),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toMap()),
    );

    if (kDebugMode) {
      print('Response: ${response.body}');
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Failed to create parent');
    }

    return User.fromJson(jsonDecode(response.body));
  }

  ///
  ///
  ///
}
