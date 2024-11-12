import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/task/task_details_view.dart';
import 'package:piggywise_child_front/widgets/hideable_code_widget.dart';

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
        title: 'Piggy',
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            'Editar',
          ),
          onPressed: () {},
        ),
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
              child: Column(
                children: <Widget>[
                  /// Details
                  _details(piggy),

                  /// Tasks
                  CupertinoListSection.insetGrouped(
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /// Title
                        const Text('Tarefas'),

                        /// Add Task
                        if (Session().user!.isParent)
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Text('Adicionar'),
                            onPressed: () {},
                          ),
                      ],
                    ),
                    children: piggy.tasks.isEmpty
                        ? <Widget>[
                            CupertinoListTile(
                              leading: const Icon(
                                CupertinoIcons.exclamationmark_triangle,
                                color: CupertinoColors.systemGrey,
                              ),
                              title: const Text(
                                  'Parece que não há tarefas ainda.'),
                              subtitle: Text(
                                Session().user!.isParent
                                    ? 'Adicione uma tarefa para seu filho'
                                    : 'Peça para seus pais adicionarem uma '
                                        'tarefa.',
                              ),
                            ),
                          ]
                        : piggy.tasks
                            .map(
                              (final Task task) => CupertinoListTile(
                                onTap: () => Utils.nav(
                                  context,
                                  TaskDetailsView(
                                    task: task,
                                    previousTitle: 'Piggy',
                                  ),
                                ),
                                title: Text(task.name),
                                subtitle: Text(task.description ?? ''),
                                leading: task.status.icon,
                                trailing: const CupertinoListTileChevron(),
                                additionalInfo: Text('${task.points} pontos'),
                              ),
                            )
                            .toList(),
                  ),
                ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /// Title
                    const Text(
                      'PiggyWise',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

                    /// Family Name
                    Text(
                      piggy.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                /// Family Code
                HideableCodeWidget(
                  code: piggy.code,
                  bordered: false,
                  title: 'Código de Sincronização',
                ),
              ],
            ),
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
                        fontSize: 14,
                      ),
                    ),

                    /// Balance
                    Text(
                      '${piggy.balance}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                /// Goal
                Column(
                  children: <Widget>[
                    /// Title
                    const Text(
                      'Meta',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

                    /// Goal
                    Text(
                      piggy.goal.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// Percentage
                    Text(
                      '${(piggy.goal > 0 ? (piggy.balance / piggy.goal) * 100 : 0.0).toStringAsFixed(0)}% concluído',
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
}
