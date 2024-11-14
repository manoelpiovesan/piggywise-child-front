import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/task_consumer.dart';
import 'package:piggywise_child_front/enums/task_status.dart';
import 'package:piggywise_child_front/models/session.dart';

import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/info_icon_widget.dart';

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
                  Text(
                    widget.task.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),

                  Utils.spacer,

                  /// Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InfoIconWidget(
                        icon: widget.task.status.icon,
                        text: widget.task.status.translation,
                        title: 'Status',
                      ),
                      Utils.spacer,
                      InfoIconWidget(
                        icon: const Icon(CupertinoIcons.calendar),
                        text: Utils.formatDate(widget.task.dueDate),
                        title: 'Data de Vencimento',
                      ),
                    ],
                  ),

                  Utils.spacer,

                  /// Actions

                  /// Set as Done (By Child)
                  if (!Session().user!.isParent &&
                      widget.task.status == TaskStatus.pending)
                    CupertinoButton.filled(
                      child: const Text('Marcar como Concluída'),
                      onPressed: () => _setAsDoneByChild(context),
                    ),

                  if (Session().user!.isParent &&
                      widget.task.status == TaskStatus.waiting_approval)
                    CupertinoButton.filled(
                      child: const Text('Aprovar Tarefa'),
                      onPressed: () => _setAsDoneByParent(context),
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
