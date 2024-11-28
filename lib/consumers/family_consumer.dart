import 'package:agattp/agattp.dart';
import 'package:flutter/foundation.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/config.dart';

///
///
///
class FamilyConsumer {
  ///
  ///
  ///
  Future<Family?> get getFamily async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(<String>[Config().backUrl, 'family'].join('/')),
    );

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar a família');
    }

    if (response.body.isEmpty) {
      return null;
    }


    Session().user!.family = Family.fromJson(response.json);

    return Family.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<Family?> join(final String code) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).postJson(
      Uri.parse(
        <String>[Config().backUrl, 'family', 'join', code.toUpperCase()]
            .join('/'),
      ),
      body: <String, dynamic>{},
    );

    if (kDebugMode) {
      print(response.json);
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      return null;
    }

    Session().user!.family = Family.fromJson(response.json);

    return Family.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<bool> get leave async {
    final AgattpResponse response = await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).get(
      Uri.parse(
        <String>[Config().backUrl, 'family', 'leave'].join('/'),
      ),
    );

    if (response.statusCode > 299 || response.statusCode < 200) {
      return false;
    }

    Session().user!.family = null;

    return true;
  }

  ///
  ///
  ///
  Future<List<User>> get getUsers async {
    final AgattpResponseJson<List<dynamic>> response = await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(<String>[Config().backUrl, 'family', 'users'].join('/')),
    );

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar os usuários da família');
    }

    final List<User> users = <User>[];
    for (final Map<String, dynamic> user in response.json) {
      users.add(User.fromJson(user));
    }


    return users;
  }

  ///
  ///
  ///
  Future<Family?> create(final Family family) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).postJson(
      Uri.parse(
        <String>[Config().backUrl, 'family'].join('/'),
      ),
      body: family.toMap(),
    );

    if (kDebugMode) {
      print(response.json);
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      return null;
    }

    Session().user!.family = Family.fromJson(response.json);

    return Family.fromJson(response.json);
  }
}
