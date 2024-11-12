import 'package:piggywise_child_front/models/task.dart';

///
///
///
class Piggy {
  int id = -1;
  String code = '';
  String name = '';
  String? description;
  List<Task> tasks = <Task>[];
  int balance = 0;
  int goal = 0;

  ///
  ///
  ///
  Piggy.fromJson(final Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    code = map['code'];
    if (map['tasks'] != null) {
      for (final Map<String, dynamic> task in map['tasks']) {
        tasks.add(Task.fromJson(task));
      }
    }
    balance = map['balance'];
    goal = map['goal'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'tasks': tasks.map((final Task task) => task.toMap()).toList(),
      'code': code,
      'balance': balance,
      'goal': goal,
    };
  }
}
