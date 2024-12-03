import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/enums/reward_status.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/reward.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/reward/reward_create_form.dart';
import 'package:piggywise_child_front/views/reward/reward_details_view.dart';

///
///
///
class RewardListWidget extends StatefulWidget {
  final Piggy piggy;

  ///
  ///
  ///
  const RewardListWidget({required this.piggy, super.key});

  @override
  State<RewardListWidget> createState() => _RewardListWidgetState();
}

class _RewardListWidgetState extends State<RewardListWidget> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<Piggy?>(
      future: PiggyConsumer().getById(widget.piggy.id),
      builder:
          (final BuildContext context, final AsyncSnapshot<Piggy?> snapshot) {
        if (snapshot.hasData) {
          return CupertinoListSection.insetGrouped(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Recompensas'),
                if (Session().user!.isParent)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(CupertinoIcons.add),
                    onPressed: () async {
                      await Utils.nav(
                        context,
                        RewardCreateForm(
                          piggyCode: snapshot.data!.code,
                        ),
                      );
                      setState(() {});
                    },
                  ),
              ],
            ),
            children: _rewardList(context, snapshot.data!),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }

  ///
  ///
  ///
  List<CupertinoListTile> _rewardList(
    final BuildContext context,
    final Piggy piggy,
  ) =>
      piggy.rewards.isEmpty
          ? _noDataAvailable(context)
          : piggy.rewards.map(
              (final Reward reward) {
                if (reward.status == RewardStatus.claimed) {
                  return CupertinoListTile(
                    title: Text(
                      reward.name,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    leading: const Icon(
                      FontAwesomeIcons.boxOpen,
                      color: CupertinoColors.systemGrey,
                    ),
                    subtitle: Text('Resgatado por ${reward.claimedBy!.name}'),
                    padding: const EdgeInsets.all(16),
                    additionalInfo: Text(
                      '${reward.points} pontos',
                    ),
                  );
                }
                return CupertinoListTile(
                  onTap: reward.points > piggy.balance
                      ? null
                      : () async {
                          await Utils.nav(
                            context,
                            RewardDetailsView(
                              reward: reward,
                            ),
                          );

                          setState(() {});
                        },
                  title: Text(
                    reward.name,
                  ),
                  leading: Icon(
                    reward.points > piggy.balance
                        ? CupertinoIcons.lock_fill
                        : FontAwesomeIcons.box,
                    color: reward.points > piggy.balance
                        ? CupertinoColors.systemGrey
                        : null,
                  ),
                  subtitle: piggy.balance / reward.points >= 1
                      ? const Text('Clique para Resgatar')
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// Progress Bar
                            LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(8),
                              minHeight: 16,
                              value: piggy.balance / reward.points,
                            ),

                            /// Remaining Points
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Faltam ${reward.points - piggy.balance} pontos',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                  padding: const EdgeInsets.all(16),
                  trailing: reward.points > piggy.balance
                      ? null
                      : const CupertinoListTileChevron(),
                  additionalInfo: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Utils.spacer,
                      Utils.spacer,
                      Text('${reward.points} pontos'),
                    ],
                  ),
                );
              },
            ).toList();

  ///
  ///
  ///
  List<CupertinoListTile> _noDataAvailable(final BuildContext context) {
    return <CupertinoListTile>[
      CupertinoListTile(
        leading: const Icon(
          CupertinoIcons.exclamationmark_triangle,
          color: CupertinoColors.systemGrey,
        ),
        title: const Text('Parece que não há recompensas ainda.'),
        subtitle: Text(
          Session().user!.isParent
              ? 'Adicione uma recompensa para seu filho'
              : 'Peça para seus pais adicionarem uma '
                  'recompensa.',
        ),
      ),
    ];
  }
}
