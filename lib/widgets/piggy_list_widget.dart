import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/models/piggy.dart';

///
///
///
class PiggyListWidget extends StatelessWidget {
  final List<Piggy> piggies;

  ///
  ///
  ///
  const PiggyListWidget({required this.piggies, super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    final List<Widget> piggiesList = piggies
        .map(
          (final Piggy piggy) => CupertinoListTile(
            title: Text(piggy.name),
            trailing: Text(piggy.name),
          ),
        )
        .toList();

    return piggiesList.isNotEmpty
        ? CupertinoListSection(
            header: const Text('Porquinhos'),
            children: piggiesList,
          )
        : const CupertinoListTile(
            leading: Icon(CupertinoIcons.add),
            title: Text('Cadastre um porquinho'),
            trailing: CupertinoListTileChevron(),
          );
  }
}
