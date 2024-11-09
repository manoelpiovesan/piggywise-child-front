import 'package:piggywise_child_front/models/tasks.dart';

///
///
///
class Piggy {
  String name = '';
  String? description;
  List<Task> tasks = <Task>[];

  ///
  ///
  ///
  Piggy.fromJson(final Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    if (map['tasks'] != null) {
      for (final Map<String, dynamic> task in map['tasks']) {
        tasks.add(Task.fromJson(task));
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
      'tasks': tasks.map((final Task task) => task.toMap()).toList(),
    };
  }
}
