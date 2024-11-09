import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/user.dart';

///
///
///
class UserWidget extends StatelessWidget {
  final User user = Session().user!;

  ///
  ///
  ///
  UserWidget({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoListTile(
      trailing: user.isParent
          ? const Icon(Icons.escalator_warning)
          : const Icon(Icons.child_care),
      leading: CircleAvatar(

        child: Text(user.name[0]),
      ),
      additionalInfo: Text(user.isParent ? 'Responsável' : 'Criança'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// Name
          Text(user.name),

          /// Username
          Text(
            '@${user.username}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
