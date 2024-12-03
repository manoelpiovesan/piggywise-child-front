import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/task_consumer.dart';
import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/session.dart';

import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/info_icon_widget.dart';
import 'package:random_avatar/random_avatar.dart';

///
///
///
class TaskDetailsView extends StatefulWidget {
  final Task task;
  final String previousTitle;

  const TaskDetailsView({
    required this.task,
    required this.previousTitle,
    super.key,
  });

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

///
///
///
class _TaskDetailsViewState extends State<TaskDetailsView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: widget.previousTitle,
        middle: const Text('Tarefa'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Utils.spacer,

                  /// Title
                  Text(
                    widget.task.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// Description
                  if (widget.task.description.isNotEmpty)
                    Text(
                      widget.task.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),

                  Utils.spacer,

                  Wrap(
                    children: <Widget>[
                      /// Points
                      InfoIconWidget(
                        icon: const Icon(CupertinoIcons.star_fill),
                        text: widget.task.points.toString(),
                        title: 'Pontos',
                      ),

                      /// Target User
                      if (widget.task.targetUser != null)
                        InfoIconWidget(
                          icon: RandomAvatar(
                            widget.task.targetUser!.name,
                            width: 24,
                            height: 24,
                          ),
                          text: widget.task.targetUser!.name,
                          title: 'Designado para',
                        ),
                    ],
                  ),

                  Wrap(
                    children: <Widget>[
                      /// Status
                      InfoIconWidget(
                        icon: widget.task.status.icon,
                        text: widget.task.status.translation,
                        title: 'Status',
                      ),

                      /// Due Date
                      if (widget.task.dueDate != null)
                      InfoIconWidget(
                        icon: const Icon(CupertinoIcons.calendar),
                        text: Utils.formatDate(widget.task.dueDate),
                        title: 'Data de Vencimento',
                      ),
                    ],
                  ),

                  /// Set as Done (By Child)
                  if (!Session().user!.isParent &&
                      widget.task.status == TaskStatus.pending)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CupertinoButton(
                        color: CupertinoColors.systemGreen,
                        child: const Text('Concluir'),
                        onPressed: () => _setAsDoneByChild(context),
                      ),
                    ),

                  /// Set as Done (By Parent)
                  if (Session().user!.isParent &&
                      widget.task.status == TaskStatus.waiting_approval)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CupertinoButton(
                        color: CupertinoColors.systemGreen,
                        child: const Text('Aprovar'),
                        onPressed: () => _setAsDoneByParent(context),
                      ),
                    ),

                  /// Delete
                  if (Session().user!.isParent)
                    CupertinoButton(
                      color: CupertinoColors.systemRed,
                      child: const Text('Excluir'),
                      onPressed: () async {
                        final bool success =
                            await TaskConsumer().delete(widget.task.id);
                        if (success && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  Future<void> _setAsDoneByChild(final BuildContext context) async {
    try {
      await TaskConsumer().setAsCompleteByChild(widget.task.id);

      if (context.mounted) {
        Navigator.pop(context);
      }
    } on Exception catch (e) {
      if (context.mounted) {
        Utils().alert(context, e.toString());
      }
    }
  }

  ///
  ///
  ///
  Future<void> _setAsDoneByParent(final BuildContext context) async {
    try {
      await TaskConsumer().setAsCompleteByParent(widget.task.id);

      if (context.mounted) {
        Navigator.pop(context);
      }
    } on Exception catch (e) {
      if (context.mounted) {
        Utils().alert(context, e.toString());
      }
    }
  }
}
