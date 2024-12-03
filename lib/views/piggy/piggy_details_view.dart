import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/reward/reward_list_view.dart';
import 'package:piggywise_child_front/views/task/done_tasks_view.dart';
import 'package:piggywise_child_front/widgets/task_list_widget.dart';

///
///
///
class PiggyDetailsView extends StatefulWidget {
  final String? previousTitle;
  final int piggyId;

  const PiggyDetailsView({
    required this.piggyId,
    super.key,
    this.previousTitle,
  });

  @override
  State<PiggyDetailsView> createState() => _PiggyDetailsViewState();
}

///
///
///
class _PiggyDetailsViewState extends State<PiggyDetailsView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(
        previousTitle: widget.previousTitle,
      ),
      child: FutureBuilder<Piggy?>(
        future: PiggyConsumer().getById(widget.piggyId),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Piggy?> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            final Piggy piggy = snapshot.data!;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /// Details
                    _details(piggy),

                    /// Rewards
                    CupertinoListSection.insetGrouped(
                      children: <Widget>[
                        CupertinoListTile(
                          padding: const EdgeInsets.all(16),
                          trailing: const CupertinoListTileChevron(),
                          title: const Text('Ver Recompensas'),
                          leading: const Icon(CupertinoIcons.gift),
                          onTap: () async {
                            await Utils.nav(
                              context,
                              RewardListView(piggy: piggy),
                            );

                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    /// Tasks
                    TaskListWidget(piggyId: piggy.id),

                    /// Done Tasks
                    CupertinoListSection.insetGrouped(
                      children: <Widget>[
                        CupertinoListTile(
                          trailing: const CupertinoListTileChevron(),
                          padding: const EdgeInsets.all(16),
                          leading:
                              const Icon(CupertinoIcons.check_mark_circled),
                          title: const Text('Tarefas Concluídas'),
                          onTap: () {
                            Utils.nav(context, DoneTasksView(piggy: piggy));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  ///
  ///
  ///
  Widget _details(final Piggy piggy) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Utils.spacer,

            /// Piggy Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /// Balance
                Column(
                  children: <Widget>[
                    /// Title
                    const Text(
                      'Saldo',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),

                    /// Balance
                    Row(
                      children: <Widget>[
                        /// Icon
                        const Icon(
                          CupertinoIcons.star_fill,
                          size: 24,
                        ),

                        const SizedBox(width: 6),

                        /// Value
                        Text(
                          '${piggy.balance}',
                          style: const TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Utils.spacer,
          ],
        ),
      );
}
