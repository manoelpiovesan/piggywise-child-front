import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/piggy/piggy_sync_form.dart';
import 'package:piggywise_child_front/widgets/hideable_code_widget.dart';
import 'package:random_avatar/random_avatar.dart';

///
///
///
class FamilyDetails extends StatefulWidget {
  final Family family;

  ///
  ///
  ///
  const FamilyDetails({required this.family, super.key});

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

///
///
///
class _FamilyDetailsState extends State<FamilyDetails> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(title: 'Detalhes da Família'),
      child: SafeArea(
        child: FutureBuilder<List<User>>(
          future: FamilyConsumer().getFamilyUsers,
          builder: (
            final BuildContext context,
            final AsyncSnapshot<List<User>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final List<Widget> usersList = snapshot.data!
                  .map(
                    (final User user) => CupertinoListTile(
                      padding: const EdgeInsets.all(16),
                      leading: RandomAvatar(user.username),
                      title: Text(user.name),
                      subtitle: Text('@${user.username}'),
                      additionalInfo: Text(user.isParent ? 'Responsável' : ''),
                      trailing: user.isParent
                          ? const Icon(Icons.escalator_warning)
                          : const Icon(Icons.child_care),
                    ),
                  )
                  .toList();

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Utils.spacer,

                      /// Family Info
                      Column(
                        children: <Widget>[
                          /// Title
                          const Text(
                            'Família',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),

                          /// Family Name
                          Text(
                            widget.family.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Utils.spacer,

                          /// Family Code
                          HideableCodeWidget(
                            code: widget.family.code,
                            title: 'Código de Convite',
                            bordered: false,
                            showQrCode: true,
                          ),
                        ],
                      ),
                      Utils.spacer,

                      /// Users
                      CupertinoListSection.insetGrouped(
                        header: const Text('Membros da família'),
                        children: usersList,
                      ),

                      Utils.spacer,

                      /// Sync Piggy
                      _syncPiggy(context),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  ///
  ///
  ///
  Widget _syncPiggy(final BuildContext context) =>
      CupertinoListSection.insetGrouped(
        children: <Widget>[
          CupertinoListTile(
            onTap: () => Utils.nav(context, const PiggySyncForm()),
            leading: const Icon(CupertinoIcons.add),
            title: const Text('Sincronize seu PiggyWise'),
            trailing: const CupertinoListTileChevron(),
          ),
        ],
      );
}
