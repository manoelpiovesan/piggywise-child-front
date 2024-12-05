import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/rewards_list_widget.dart';

///
///
///
class RewardListView extends StatelessWidget {
  final Piggy piggy;

  ///
  ///
  ///
  const RewardListView({
    required this.piggy,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) => CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        navigationBar: Utils().navBar(title: 'Recompensas'),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              /// Rewards List
              RewardListWidget(piggy: piggy),
            ],
          ),
        ),
      );
}
