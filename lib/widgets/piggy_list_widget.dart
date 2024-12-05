import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/piggy/piggy_details_view.dart';
import 'package:piggywise_child_front/views/piggy/piggy_sync_form.dart';
import 'package:piggywise_child_front/widgets/list_tile_no_data.dart';

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
              ListTileNoDataYet(
                onTap: () async => Utils.nav(context, const PiggySyncForm()),
                title: 'Sincronize seu PiggyWise',
                icon: const Icon(CupertinoIcons.link),
              ),
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
                children: piggiesList,
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
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/piggy.svg',
                height: length > 1 ? 60 : 90,
                colorFilter: ColorFilter.mode(
                  CupertinoTheme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              Utils.spacer,

              /// Header
              Text(
                piggy.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// Subtitle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// Icon
                  const Icon(
                    CupertinoIcons.star_fill,
                    color: CupertinoColors.systemGrey,
                    size: 16,
                  ),

                  const SizedBox(width: 3),

                  /// Balance
                  Text(
                    piggy.balance.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGrey,
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
