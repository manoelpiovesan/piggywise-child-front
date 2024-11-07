import 'package:piggywise_child_front/models/tasks.dart';
import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Piggy {
  String name = '';
  String description = '';
  List<User> members = <User>[];
  List<Task> tasks = <Task>[];
  int balance = 0;

  ///
  ///
  ///
  Piggy.fromJson(final Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    balance = map['balance'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'members': members.map((final User member) => member.toMap()).toList(),
      'tasks': tasks.map((final Task task) => task.toMap()).toList(),
      'balance': balance,
    };
  }
}
