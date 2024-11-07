import 'dart:convert';

import 'package:agattp/agattp.dart';
import 'package:http/http.dart' as http;
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
  Future<bool> login(final String username, final String password) async {
    final Config config = Config();

    /// Auth Basic
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(username: username, password: password).getJson(
      Uri.parse('${Config().backUrl}/users/me'),
    );

    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      Session().user = User.fromJson(jsonDecode(response.body));
      return true;
    } else {
      print('Failed to login: ${response.statusCode}');
      return false;
    }
  }
}
