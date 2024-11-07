import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Task {
  String title = '';
  String description = '';
  int points = 0;
  List<User> members = <User>[];

  ///
  ///
  ///
  Task.fromJson(final Map<String, dynamic> map) {
    title = map['title'];
    description = map['description'];
    points = map['points'];
    if (map['members'] != null) {
      for (final Map<String, dynamic> member in map['members']) {
        members.add(User.fromJson(member));
      }
    }
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'points': points,
      'members': members.map((final User member) => member.toMap()).toList(),
    };
  }
}
