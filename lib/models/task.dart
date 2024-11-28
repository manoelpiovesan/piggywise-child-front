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
  User? targetUser;

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
    targetUser =
        map['targetUser'] != null ? User.fromJson(map['targetUser']) : null;
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
      'targetUser': targetUser?.toMap(),
      'status': status.name,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
