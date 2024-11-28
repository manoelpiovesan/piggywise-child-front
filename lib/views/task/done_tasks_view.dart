import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/task_list_widget.dart';

class DoneTasksView extends StatelessWidget {
  final Piggy piggy;

  const DoneTasksView({required this.piggy, super.key});

  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: Utils().navBar(title: 'Tarefas Concluídas'),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            /// Task Done List
            TaskListWidget(piggyId: piggy.id, showOnlyDoneTasks: true),
          ],
        ),
      ),
    );
  }
}
