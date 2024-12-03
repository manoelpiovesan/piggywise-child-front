import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/task/task_create_form.dart';
import 'package:piggywise_child_front/views/task/task_details_view.dart';
import 'package:random_avatar/random_avatar.dart';

///
///
///
class TaskListWidget extends StatefulWidget {
  final int piggyId;
  final bool showOnlyDoneTasks;

  ///
  ///
  ///
  const TaskListWidget({
    required this.piggyId,
    super.key,
    this.showOnlyDoneTasks = false,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<Piggy?>(
      future: PiggyConsumer().getById(widget.piggyId),
      builder:
          (final BuildContext context, final AsyncSnapshot<Piggy?> snapshot) {
        if (snapshot.hasData) {
          return CupertinoListSection.insetGrouped(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Tarefas'),
                if (Session().user!.isParent && !widget.showOnlyDoneTasks)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(CupertinoIcons.add),
                    onPressed: () async {
                      await Utils.nav(
                        context,
                        TaskCreateForm(
                          piggy: snapshot.data!,
                        ),
                      );
                      setState(() {});
                    },
                  ),
              ],
            ),
            children: _taskList(context, snapshot.data!),
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
  List<Widget> _taskList(
    final BuildContext context,
    final Piggy piggy,
  ) =>
      piggy.tasks.isNotEmpty
          ? piggy.tasks.where(
              (final Task task) {
                if (widget.showOnlyDoneTasks) {
                  return task.status == TaskStatus.done;
                }
                return task.status != TaskStatus.done;
              },
            ).map(
              (final Task task) {
                bool forMe = true;
                if (task.targetUser != null &&
                    task.targetUser!.id != Session().user!.id) {
                  forMe = false;
                }
                if (Session().user!.isParent) {
                  forMe = true;
                }

                return CupertinoListTile(
                  onTap: forMe
                      ? () async {
                          await Utils.nav(
                            context,
                            TaskDetailsView(
                              task: task,
                              previousTitle: 'Piggy',
                            ),
                          );

                          setState(() {});
                        }
                      : null,
                  title: Row(
                    children: <Widget>[
                      /// Title
                      Text(
                        task.name,
                        style: task.status == TaskStatus.done
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough,
                              )
                            : null,
                      ),

                      Utils.spacer,
                      Utils.spacer,
                    ],
                  ),
                  //Text('${task.points} pontos'),
                  leading: task.status.icon,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Description
                      if (task.description.isNotEmpty)
                        Text(
                          task.description!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),

                      /// Due date
                      if (task.dueDate != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'Expira ${Utils.formatDate(task.dueDate)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  trailing: forMe ? const CupertinoListTileChevron() : null,
                  additionalInfo: Row(
                    children: <Widget>[
                      /// For person
                      if (task.targetUser != null)
                        Row(
                          children: <Widget>[
                            RandomAvatar(
                              task.targetUser!.username,
                              width: 20,
                              height: 20,
                            ),
                            Utils.spacer,
                            Text(
                              ' Para ${task.targetUser!.name}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: <Widget>[
                            const Icon(
                              CupertinoIcons.group,
                              color: CupertinoColors.systemGrey,
                            ),
                            Utils.spacer,
                            const Text(
                              ' Para todos',
                              style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ],
                        ),
                      Utils.spacer,
                    ],
                  ),
                );
              },
            ).toList()
          : _noDataAvailable(context, piggy);

  ///
  ///
  ///
  List<CupertinoListTile> _noDataAvailable(
    final BuildContext context,
    final Piggy piggy,
  ) {
    return <CupertinoListTile>[
      CupertinoListTile(
        onTap: () async {
          await Utils.nav(
            context,
            TaskCreateForm(
              piggy: piggy,
            ),
          );
          setState(() {});
        },
        trailing: const CupertinoListTileChevron(),
        padding: const EdgeInsets.all(16),
        leading: const Icon(
          CupertinoIcons.exclamationmark_triangle,
          color: CupertinoColors.systemGrey,
        ),
        title: const Text('Parece que não há tarefas ainda.'),
        subtitle: Text(
          Session().user!.isParent
              ? 'Adicione uma tarefa para seu filho'
              : 'Peça para seus pais adicionarem uma '
                  'tarefa.',
        ),
      ),
    ];
  }
}
