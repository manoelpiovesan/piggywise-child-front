import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/task_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/task.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/user_list_view.dart';
import 'package:piggywise_child_front/widgets/form_prefix.dart';

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
  User? targetUser;
  bool forAll = true;
  bool showDueDate = false;

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) => CupertinoPageScaffold(
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
                    CupertinoFormRow(
                      prefix: const FormPrefix(
                        icon: CupertinoIcons.textformat,
                        text: 'Nome',
                      ),
                      child: CupertinoTextFormFieldRow(
                        placeholder: 'Nome da Tarefa',
                        onChanged: (final String value) {
                          task.name = value;
                        },
                      ),
                    ),

                    /// Task description
                    CupertinoFormRow(
                      prefix: const FormPrefix(
                        icon: CupertinoIcons.text_bubble,
                        text: 'Descrição',
                      ),
                      child: CupertinoTextFormFieldRow(
                        placeholder: 'Descrição',
                        onChanged: (final String value) {
                          task.description = value;
                        },
                      ),
                    ),

                    /// Task points
                    CupertinoFormRow(
                      prefix: const FormPrefix(
                        icon: CupertinoIcons.star_fill,
                        text: 'Pontos',
                      ),
                      child: CupertinoTextFormFieldRow(
                        placeholder: 'Pontos',
                        keyboardType: TextInputType.number,
                        onChanged: (final String value) {
                          task.points = int.parse(value);
                        },
                      ),
                    ),

                    /// Due date switch
                    CupertinoFormRow(
                      prefix: const FormPrefix(
                        icon: Icons.calendar_month,
                        text: 'Limite de Tempo',
                      ),
                      child: CupertinoListTile(
                        trailing: CupertinoSwitch(
                          value: showDueDate,
                          onChanged: (final bool value) {
                            if (value) {
                              task.dueDate = null;
                            }
                            setState(() {
                              showDueDate = value;
                            });
                          },
                        ),
                        title: const Text(''),
                      ),
                    ),

                    /// Task due date
                    if (showDueDate)
                      CupertinoFormRow(
                        prefix: const FormPrefix(
                          icon: CupertinoIcons.calendar,
                          text: 'Data de Vencimento',
                        ),
                        child: CupertinoListTile(
                          onTap: () async => _showModal(context),
                          title: Text(
                            Utils.formatDate(task.dueDate).isEmpty
                                ? 'Selecione a data'
                                : Utils.formatDate(task.dueDate),
                          ),
                        ),
                      ),

                    /// For all switch
                    CupertinoFormRow(
                      prefix: const FormPrefix(
                        icon: Icons.group,
                        text: 'Para todos',
                      ),
                      child: CupertinoListTile(
                        trailing: CupertinoSwitch(
                          value: forAll,
                          onChanged: (final bool value) {
                            if (value) {
                              targetUser = null;
                            }
                            setState(() {
                              forAll = value;
                            });
                          },
                        ),
                        title: const Text(''),
                      ),
                    ),

                    /// Target user
                    if (!forAll)
                      CupertinoFormRow(
                        prefix: const FormPrefix(
                          icon: Icons.person_add,
                          text: 'Para',
                        ),
                        child: CupertinoListTile(
                          onTap: () => selectTargetUser,
                          trailing: const CupertinoListTileChevron(),
                          title: targetUser != null
                              ? Text(targetUser!.name)
                              : const Text('Selecione o filho(a)'),
                        ),
                      ),
                  ],
                ),
                Utils.spacer,

                /// Create button
                CupertinoButton.filled(
                  child: const Text('Criar'),
                  onPressed: () async {
                    if (!forAll && targetUser == null) {
                      Utils().alert(
                        context,
                        'Selecione o filho(a) para quem a tarefa será criada',
                      );
                      return;
                    }

                    final Task? created = await _create(
                      task,
                      widget.piggy.id,
                      targetUser,
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
  Future<void> get selectTargetUser async {
    final User? user = await Navigator.of(context).push(
      CupertinoPageRoute<User>(
        builder: (final BuildContext context) => const UserListView(),
      ),
    );
    targetUser = user;
    setState(() {});
  }

  ///
  ///
  ///
  Future<Task?> _create(
    final Task task,
    final int piggyId,
    final User? targetUser,
    final BuildContext context,
  ) async {
    try {
      return await TaskConsumer().create(task, piggyId, targetUser);
    } on Exception {
      Utils().alert(context, 'Falha ao criar tarefa');
    }
    return null;
  }
}
