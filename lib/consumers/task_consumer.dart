import 'package:agattp/agattp.dart';
import 'package:flutter/foundation.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/config.dart';

///
///
///
class TaskConsumer {
  ///
  ///
  ///
  Future<Task?> create(
    final Task task,
    final int piggyId,
    final User? targetUser,
  ) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).postJson(
      Uri.parse(
        <String>[
          <String>[
            Config().backUrl,
            'tasks',
          ].join('/'),
          '?piggyId=$piggyId',
          if (targetUser != null) '&targetUserId=${targetUser.id}',
        ].join(),
      ),
      body: task.toMap(),
    );


    if (kDebugMode) {
      print('TaskConsumer.create: ${response.json}');
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar a tarefa');
    }

    return Task.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<Task?> setAsCompleteByChild(final int taskId) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(
        <String>[
          Config().backUrl,
          'tasks',
          taskId.toString(),
          'complete',
        ].join('/'),
      ),
    );

    if (kDebugMode) {
      print('TaskConsumer.setAsCompleteByChild: ${response.json}');
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar a tarefa');
    }

    return Task.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<Task?> setAsCompleteByParent(final int taskId) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(
        <String>[
          Config().backUrl,
          'tasks',
          taskId.toString(),
          'approve',
        ].join('/'),
      ),
    );

    if (kDebugMode) {
      print('TaskConsumer.setAsCompleteByParent: ${response.json}');
    }

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar a tarefa');
    }

    return Task.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<bool> delete(final int taskId) async {
    final AgattpResponse response = await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).delete(
      Uri.parse(
        <String>[
          Config().backUrl,
          'tasks',
          taskId.toString(),
        ].join('/'),
      ),
    );

    if (response.statusCode > 299 || response.statusCode < 200) {
      return false;
    }

    return true;
  }
}
