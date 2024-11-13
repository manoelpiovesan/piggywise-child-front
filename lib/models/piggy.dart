import 'package:piggywise_child_front/enums/task_status.dart';
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

  ///
  ///
  ///
  int get balance => tasks.fold<int>(
        0,
        (final int previousValue, final Task element) {
          if (element.status == TaskStatus.done) {
            return previousValue + element.points;
          }
          return previousValue;
        },
      );

  ///
  ///
  ///
  int get waitingDeposit => tasks.fold<int>(
        0,
        (final int previousValue, final Task element) {
          if (element.status == TaskStatus.waiting_deposit) {
            return previousValue + element.points;
          }
          return previousValue;
        },
      );

  ///
  ///
  ///
  double get progress {
    if (goal == 0) {
      return 0;
    }
    return balance / goal;
  }
}
