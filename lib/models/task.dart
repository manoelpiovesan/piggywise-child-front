import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Task {
  String name = '';
  String description = '';
  int points = 0;
  TaskStatus status = TaskStatus.pending;
  List<User> users = <User>[];

  ///
  ///
  ///
  Task.fromJson(final Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    points = map['points'];
    status = TaskStatus.fromString(map['status']);
    if (map['users'] != null) {
      for (final Map<String, dynamic> member in map['users']) {
        users.add(User.fromJson(member));
      }
    }
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'points': points,
      'users': users.map((final User member) => member.toMap()).toList(),
      'status': status.toString(),
    };
  }
}
