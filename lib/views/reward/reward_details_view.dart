import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/reward_consumer.dart';
import 'package:piggywise_child_front/models/reward.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/info_icon_widget.dart';

///
///
///
class RewardDetailsView extends StatefulWidget {
  final Reward reward;

  const RewardDetailsView({required this.reward, super.key});

  @override
  State<RewardDetailsView> createState() => _RewardDetailsViewState();
}

///
///
///
class _RewardDetailsViewState extends State<RewardDetailsView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) => CupertinoPageScaffold(
        navigationBar: Utils().navBar(title: 'Recompensa'),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Utils.spacer,

                  /// Name
                  Text(
                    widget.reward.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// Description
                  if (widget.reward.description != null)
                    Text(
                      widget.reward.description!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                  Utils.spacer,

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// Points
                      InfoIconWidget(
                        icon: const Icon(CupertinoIcons.star_fill),
                        text: widget.reward.points.toString(),
                        title: 'Valor',
                      ),
                    ],
                  ),

                  /// Claim
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CupertinoButton.filled(
                      child: const Text('Reivindicar'),
                      onPressed: () async {
                        final Reward? reward = await RewardConsumer()
                            .claimReward(widget.reward.id);

                        if (reward != null) {
                          if (context.mounted) {
                            Navigator.pop(context, reward);
                          }
                        } else {
                          if (context.mounted) {
                            Utils().alert(
                              context,
                              'Erro ao reivindicar recompensa',
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
