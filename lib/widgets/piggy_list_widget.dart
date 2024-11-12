import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/piggy/piggy_sync_form.dart';

///
///
///
class PiggyListWidget extends StatelessWidget {

  ///
  ///
  ///
  const PiggyListWidget({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<List<Piggy>>(
      future: PiggyConsumer().getPiggies,
      builder: (
        final BuildContext context,
        final AsyncSnapshot<List<Piggy>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.data!.isEmpty) {
          return _noData(context);
        } else {
          final List<Widget> piggiesList = snapshot.data!
              .map(
                (final Piggy piggy) => CupertinoListTile(
                  title: Text(piggy.name),
                  subtitle: Text(piggy.code),
                  leading: const Icon(Icons.punch_clock_rounded),
                ),
              )
              .toList();

          return SafeArea(
            child: CupertinoListSection.insetGrouped(
              footer: CupertinoButton(
                child: const Icon(CupertinoIcons.add),
                onPressed: () => Utils.nav(context, const PiggySyncForm()),
              ),
              backgroundColor: CupertinoColors.white,
              header: const Text('Seus Piggies'),
              children: <Widget>[
                ...piggiesList,
              ],
            ),
          );
        }
      },
    );
  }

  ///
  ///
  ///
  Widget _noData(final BuildContext context) => CupertinoListTile(
        onTap: () => Utils.nav(context, const PiggySyncForm()),
        leading: const Icon(CupertinoIcons.add),
        title: const Text('Sincronize seu PiggyWise'),
        trailing: const CupertinoListTileChevron(),
      );
}
