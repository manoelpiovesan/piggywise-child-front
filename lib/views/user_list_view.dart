import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/list_tile_no_data.dart';
import 'package:random_avatar/random_avatar.dart';

///
///
///
class UserListView extends StatelessWidget {
  const UserListView({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: Utils().navBar(),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      // navigationBar: Utils().navBar(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<List<User>>(
                future: FamilyConsumer().getUsers,
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<List<User>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final List<User> users = snapshot.data!;
                    if (users.length == 1) {
                      return CupertinoListSection.insetGrouped(
                        children: const <Widget>[
                          ListTileNoDataYet(
                            title: 'Nenhum filho(a) encontrado',
                            icon: Icon(
                              CupertinoIcons.person,
                              color: CupertinoColors.systemGrey,
                            ),
                            subtitle:
                                'Eles aparecerão aqui assim que se juntarem à '
                                'sua família',
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: <Widget>[
                        /// Lista
                        CupertinoListSection.insetGrouped(
                          header: const Text('Selecione um(a) filho(a)'),
                          children: <Widget>[
                            ...users.map(
                              (final User user) {
                                if (user.isParent) {
                                  return const SizedBox.shrink();
                                }
                                return CupertinoListTile(
                                  padding: const EdgeInsets.all(16),
                                  leading: RandomAvatar(
                                    user.username,
                                    height: 70,
                                    width: 70,
                                  ),
                                  title: Text(user.name),
                                  subtitle: Text(user.username),
                                  onTap: () {
                                    Navigator.of(context).pop(user);
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                        /// Clear
                        CupertinoButton(
                          child: const Text('Limpar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
