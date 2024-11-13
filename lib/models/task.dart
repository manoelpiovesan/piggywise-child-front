import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Task {
  int id = -1;
  String name = '';
  String description = '';
  int points = 0;
  DateTime? dueDate;
  TaskStatus status = TaskStatus.pending;
  List<User> users = <User>[];

  ///
  ///
  ///
  Task();

  ///
  ///
  ///
  Task.fromJson(final Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    points = map['points'];
    status = TaskStatus.fromString(map['status']);
    if (map['users'] != null) {
      for (final Map<String, dynamic> member in map['users']) {
        users.add(User.fromJson(member));
      }
    }
    dueDate = map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null;
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'users': users.map((final User member) => member.toMap()).toList(),
      'status': status.name,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
