import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/join_family_form.dart';
import 'package:piggywise_child_front/widgets/piggy_list_widget.dart';

///
///
///
class FamilyWidget extends StatefulWidget {
  const FamilyWidget({super.key});

  @override
  State<FamilyWidget> createState() => _FamilyWidgetState();
}

///
///
///
class _FamilyWidgetState extends State<FamilyWidget> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<Family?>(
      future: FamilyConsumer().getFamily,
      builder: (
        final BuildContext context,
        final AsyncSnapshot<Family?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.data == null) {
          return CupertinoListTile(
            leading: const Icon(CupertinoIcons.group_solid),
            onTap: () async {
              await _joinOrCreateFamily(context);
              setState(() {});
            },
            trailing: const CupertinoListTileChevron(),
            title: const Text(
              'Crie ou se junte a uma família',
            ),
          ); // Levar para criar uma familia
        } else {
          return Column(
            children: <Widget>[
              /// Family Info
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.group_solid),
                trailing: const CupertinoListTileChevron(),
                additionalInfo: Text('${snapshot.data!.usersQty} membros'),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Família',
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    Text(snapshot.data!.name),
                  ],
                ),
              ),

              /// Piggies
              PiggyListWidget(piggies: snapshot.data!.piggies),
            ],
          );
        }
      },
    );
  }

  ///
  ///
  ///
  Future<void> _joinOrCreateFamily(final BuildContext context) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (final BuildContext context) => CupertinoActionSheet(
        title: const Text('Família'),
        actions: <Widget>[
          if (Session().user!.isParent)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Criar uma família'),
            ),
          CupertinoActionSheetAction(
            onPressed: () async {
              await Utils.nav(context, const JoinFamilyForm());
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Se juntar a uma família'),
          ),
        ],
      ),
    );
  }
}
