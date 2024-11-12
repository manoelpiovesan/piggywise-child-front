import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';

///
///
///
class TaskDetailsView extends StatefulWidget {
  final Task task;
  final String previousTitle;

  const TaskDetailsView(
      {required this.task, required this.previousTitle, super.key});

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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
