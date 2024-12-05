import 'package:piggywise_child_front/enums/reward_status.dart';
import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/reward.dart';
import 'package:piggywise_child_front/models/task.dart';

///
///
///
class Piggy {
  int id = -1;
  String code = '';
  String name = '';
  String? description;
  int balance = 0;
  List<Task> tasks = <Task>[];
  List<Reward> rewards = <Reward>[];

  ///
  ///
  ///
  Piggy.fromJson(final Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    code = map['code'];
    balance = map['balance'];
    if (map['tasks'] != null) {
      for (final Map<String, dynamic> task in map['tasks']) {
        tasks.add(Task.fromJson(task));
      }
    }
    if (map['rewards'] != null) {
      for (final Map<String, dynamic> reward in map['rewards']) {
        rewards.add(Reward.fromJson(reward));
      }
    }
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'code': code,
      'balance': balance,
      'tasks': tasks.map((final Task task) => task.toMap()).toList(),
      'rewards': rewards.map((final Reward reward) => reward.toMap()).toList(),
    };
  }

  ///
  ///
  ///
  double get tasksDonePercentage {
    if (tasks.isEmpty) {
      return 0;
    }
    final int doneTasks =
        tasks.where((final Task task) => task.status == TaskStatus.done).length;
    return doneTasks / tasks.length;
  }

  ///
  ///
  ///
  double get rewardsClaimedPercentage {
    if (rewards.isEmpty) {
      return 0;
    }
    final int claimedRewards = rewards
        .where((final Reward reward) => reward.status == RewardStatus.claimed)
        .length;
    return claimedRewards / rewards.length;
  }

  ///
  ///
  ///
  int get rewardsClaimedQty {
    if (rewards.isEmpty) {
      return 0;
    }
    return rewards
        .where((final Reward reward) => reward.status == RewardStatus.claimed)
        .length;
  }
}
