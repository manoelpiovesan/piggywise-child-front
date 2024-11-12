import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/utils/utils.dart';

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
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: Utils().navBar(
        title: 'Criar Família',
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            CupertinoFormSection(
              children: <Widget>[
                /// Name
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Nome',
                    onChanged: (final String value) {
                      family.name = value;
                    },
                  ),
                ),

                /// Description
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Descrição',
                    onChanged: (final String value) {
                      family.description = value;
                    },
                  ),
                ),
              ],
            ),

            /// Save Button
            CupertinoButton(
              child: const Text('Criar Família'),
              onPressed: () {
                try {
                  FamilyConsumer().createFamily(family);
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
}
