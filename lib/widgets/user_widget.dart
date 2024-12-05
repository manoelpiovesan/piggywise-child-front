import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/settings_view.dart';
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
          onTap: () async => Utils.nav(context, const SettingsView()),
          trailing: _trailingIcon,
          additionalInfo: _additionalInfo,
          leading: RandomAvatar(user.username, height: 70, width: 70),
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
  Widget get _trailingIcon => user.isParent
      ? const Icon(Icons.escalator_warning)
      : const Icon(Icons.child_care);

  ///
  ///
  ///
  Widget get _additionalInfo => Text(
        user.isParent ? 'Responsável' : 'Criança',
      );
}
