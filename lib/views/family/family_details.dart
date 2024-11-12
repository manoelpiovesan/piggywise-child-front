import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';

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
                      title: Text(user.name),
                      subtitle: Text('@${user.username}'),
                      leading: user.isParent
                          ? const Icon(Icons.child_care)
                          : const Icon(Icons.escalator_warning),
                    ),
                  )
                  .toList();

              return SafeArea(
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
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CupertinoColors.systemGrey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Código de Convite',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              Text(
                                widget.family.code,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: CupertinoColors.systemGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Users
                    CupertinoListSection(
                      header: const Text('Membros da família'),
                      children: usersList,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
