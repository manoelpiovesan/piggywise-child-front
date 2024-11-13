import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/task_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/task/task_details_view.dart';

///
///
///
class TaskCreateForm extends StatefulWidget {
  final Piggy piggy;

  const TaskCreateForm({required this.piggy, super.key});

  @override
  State<TaskCreateForm> createState() => _TaskCreateFormState();
}

///
///
///
class _TaskCreateFormState extends State<TaskCreateForm> {
  final Task task = Task();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(title: 'Nova Tarefa'),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Utils.spacer,

              CupertinoFormSection.insetGrouped(
                children: <Widget>[
                  /// Task name
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.person),
                    placeholder: 'Nome da Tarefa',
                    onChanged: (final String value) {
                      task.name = value;
                    },
                  ),

                  /// Task description
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.text_bubble),
                    placeholder: 'Descrição',
                    onChanged: (final String value) {
                      task.description = value;
                    },
                  ),

                  /// Task points
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.money_dollar),
                    placeholder: 'Pontos',
                    keyboardType: TextInputType.number,
                    onChanged: (final String value) {
                      task.points = int.parse(value);
                    },
                  ),

                  /// Task due date
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.calendar),
                    title: const Text('Data de Vencimento'),
                    onTap: () async => _showModal(context),
                    trailing: Text(
                      Utils.formatDate(task.dueDate),
                    ),
                  ),
                ],
              ),
              Utils.spacer,

              /// Create button
              CupertinoButton.filled(
                child: const Text('Criar'),
                onPressed: () async {
                  final Task? created = await _create(
                    task,
                    widget.piggy.id,
                    context,
                  );
                  if (created != null && context.mounted) {
                    Navigator.pop(context);
                  }
                },
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
  Future<void> _showModal(final BuildContext context) async {
    final DateTime now = DateTime.now();
    await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (final BuildContext context) {
        return SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            minimumDate: now,
            initialDateTime: now,
            onDateTimeChanged: (final DateTime value) {
              task.dueDate = value;
            },
          ),
        );
      },
    );

    setState(() {});
  }

  ///
  ///
  ///
  Future<Task?> _create(
    final Task task,
    final int piggyId,
    final BuildContext context,
  ) async {
    try {
      return await TaskConsumer().create(task, piggyId);
    } on Exception {
      Utils().alert(context, 'Falha ao criar tarefa');
    }
    return null;
  }
}
