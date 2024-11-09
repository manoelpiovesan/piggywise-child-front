import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Family {
  String name = '';
  String? description;
  String code = '';
  List<User> users = <User>[];
  List<Piggy> piggies = <Piggy>[];
  int usersQty = 0;

  ///
  ///
  ///
  Family();

  ///r
  ///
  ///
  Family.fromJson(final Map<String, dynamic> map) {
    name = map['name'] ?? '';
    description = map['description'] ?? '';
    code = map['code'] ?? '';
    if (map['users'] != null) {
      for (final Map<String, dynamic> user in map['users']) {
        users.add(User.fromJson(user));
      }
    }
    if (map['piggies'] != null) {
      for (final Map<String, dynamic> piggy in map['piggies']) {
        piggies.add(Piggy.fromJson(piggy));
      }
    }
    usersQty = map['usersQty'] ?? 0;
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'description': description,
      'users': users.map((final User user) => user.toMap()).toList(),
      'piggies': piggies.map((final Piggy piggy) => piggy.toMap()).toList(),
      'usersQty': usersQty,
    };
  }
}
