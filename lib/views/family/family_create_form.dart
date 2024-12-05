import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/form_prefix.dart';

///
///
///
class FamilyCreateForm extends StatefulWidget {
  const FamilyCreateForm({super.key});

  @override
  State<FamilyCreateForm> createState() => _FamilyCreateFormState();
}

///
///
///
class _FamilyCreateFormState extends State<FamilyCreateForm> {
  Family family = Family();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) => CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        navigationBar: Utils().navBar(
          title: 'Criar Família',
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Utils.spacer,

              /// Form
              CupertinoFormSection.insetGrouped(
                children: <Widget>[
                  /// Name
                  CupertinoFormRow(
                    prefix: const FormPrefix(
                      icon: Icons.group,
                      text: 'Nome',
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Nome',
                      onChanged: (final String value) => family.name = value,
                    ),
                  ),

                  /// Description
                  CupertinoFormRow(
                    prefix: const FormPrefix(
                      icon: Icons.text_fields,
                      text: 'Descrição',
                      optional: true,
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Descrição',
                      onChanged: (final String value) =>
                          family.description = value,
                    ),
                  ),
                ],
              ),
              Utils.spacer,

              /// Save Button
              CupertinoButton.filled(
                child: const Text('Criar Família'),
                onPressed: () {
                  try {
                    FamilyConsumer().create(family);
                    Navigator.pop(context);
                  } on Exception catch (e) {
                    Utils().alert(context, e.toString());
                  }
                },
              ),
            ],
          ),
        ),
      );
}
