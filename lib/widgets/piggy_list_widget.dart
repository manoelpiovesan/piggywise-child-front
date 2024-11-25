import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/piggy/piggy_details_view.dart';
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
          return CupertinoListSection.insetGrouped(
            children: <Widget>[
              _noData(context),
            ],
          );
        } else {
          final List<Widget> piggiesList = snapshot.data!
              .map(
                (final Piggy piggy) =>
                    _piggyCard(context, piggy, snapshot.data!.length),
              )
              .toList();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: piggiesList.length > 1 ? 2 : 1,
                children: <Widget>[
                  ...piggiesList,
                ],
              ),
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
    padding: const EdgeInsets.all(16),
    leading: const Icon(
      CupertinoIcons.link,
    ),
    title: const Text('Sincronize seu PiggyWise'),
    trailing: const CupertinoListTileChevron(),
  );

  ///
  ///
  ///
  Widget _piggyCard(
    final BuildContext context,
    final Piggy piggy,
    final int length,
  ) =>
      GestureDetector(
        onTap: () => Utils.nav(
          context,
          PiggyDetailsView(piggyId: piggy.id),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CupertinoColors.systemFill,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// Piggy Circle
              // CircularPercentIndicator(
              //   radius: length > 1 ? 50 : 150,
              //   lineWidth: length > 1 ? 10 : 16,
              //   percent: piggy.progress,
              //   linearGradient: LinearGradient(
              //     colors: <Color>[
              //       Colors.purple.shade100,
              //       Colors.purple,
              //     ],
              //   ),
              //   center: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       /// Image
              //       SvgPicture.asset(
              //         'assets/images/piggy.svg',
              //         height: length > 1 ? 60 : 90,
              //         colorFilter: const ColorFilter.mode(
              //           Colors.grey,
              //           BlendMode.srcIn,
              //         ),
              //       ),
              //     ],
              //   ),
              //   backgroundColor: Colors.grey,
              // ),
              Utils.spacer,

              /// Header
              Text(
                piggy.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              /// Balance
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// Percentage
                  Text(
                    piggy.balance.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
