import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/config.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/login_view.dart';
import 'package:random_avatar/random_avatar.dart';

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
    return CupertinoListSection.insetGrouped(
      margin: const EdgeInsets.all(12),
      children: <Widget>[
        CupertinoListTile(
          padding: const EdgeInsets.all(16),
          onTap: () async => _showUserDetails(context),
          trailing: user.isParent
              ? const Icon(Icons.escalator_warning)
              : const Icon(Icons.child_care),
          leading: RandomAvatar(user.username, height: 70, width: 70),
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
        ),
      ],
    );
  }

  ///
  ///
  ///
  Future<void> _showUserDetails(final BuildContext context) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (final BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          /// Modo Escuro
          CupertinoActionSheetAction(
            onPressed: () {
              Utils.toggleTheme;
              Navigator.pop(context);
            },
            child: Text(
              Config.instance.brightness == Brightness.dark
                  ? 'Modo Claro'
                  : 'Modo Escuro',
            ),
          ),

          /// Logout
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Session.logout(context);
            },
            child: const Text('Logout'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ),
    );
  }
}
