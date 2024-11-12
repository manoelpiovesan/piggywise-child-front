import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/login_view.dart';

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
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CupertinoColors.systemGroupedBackground,
        ),
      ),
      child: CupertinoListTile(
        onTap: () async => _showUserDetails(context),
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
      ),
    );
  }

  ///
  ///
  ///
  Future<void> _showUserDetails(final BuildContext context) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (final BuildContext context) => CupertinoActionSheet(
        title: const Text('Usuário'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Editar'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Utils.navReplace(context, const LoginView()),
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
