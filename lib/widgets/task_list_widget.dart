import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/task/task_create_form.dart';
import 'package:piggywise_child_front/views/task/task_details_view.dart';

///
///
///
class TaskListWidget extends StatefulWidget {
  final int piggyId;

  ///
  ///
  ///
  const TaskListWidget({required this.piggyId, super.key});

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
                if (Session().user!.isParent)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Adicionar Tarefa',
                    ),
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
  List<CupertinoListTile> _taskList(
    final BuildContext context,
    final Piggy piggy,
  ) =>
      piggy.tasks.isNotEmpty
          ? piggy.tasks
              .map(
                (final Task task) => CupertinoListTile(
                  onTap: () async {
                    await Utils.nav(
                      context,
                      TaskDetailsView(
                        task: task,
                        previousTitle: 'Piggy',
                      ),
                    );

                    setState(() {});
                  },
                  title: Text(
                    task.name,
                    style: task.status == TaskStatus.done
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          )
                        : null,
                  ),
                  leading: task.status.icon,
                  subtitle: Text('Até ${Utils.formatDate(task.dueDate)}'),
                  padding: const EdgeInsets.all(8),
                  trailing: const CupertinoListTileChevron(),
                  additionalInfo: Text('${task.points} pontos'),
                ),
              )
              .toList()
          : _noDataAvailable(context);

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
