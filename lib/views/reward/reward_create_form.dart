import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/reward_consumer.dart';
import 'package:piggywise_child_front/models/reward.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/form_prefix.dart';

///
///
///
class RewardCreateForm extends StatefulWidget {
  final String piggyCode;

  const RewardCreateForm({required this.piggyCode, super.key});

  @override
  State<RewardCreateForm> createState() => _RewardCreateFormState();
}

///
///
///
class _RewardCreateFormState extends State<RewardCreateForm> {
  Reward reward = Reward();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(
        title: 'Criar Recompensa',
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
                    icon: Icons.redeem,
                    text: 'Nome',
                  ),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Nome',
                    onChanged: (final String value) {
                      reward.name = value;
                    },
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
                    onChanged: (final String value) {
                      reward.description = value;
                    },
                  ),
                ),

                /// Points
                CupertinoFormRow(
                  prefix: const FormPrefix(
                    icon: Icons.monetization_on,
                    text: 'Meta de Pontos',
                  ),
                  child: CupertinoTextFormFieldRow(
                    keyboardType: TextInputType.number,
                    placeholder: 'Meta de Pontos',
                    onChanged: (final String value) {
                      reward.points = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Utils.spacer,

            /// Save Button
            CupertinoButton.filled(
              child: const Text('Criar Recompensa'),
              onPressed: () {
                try {
                  RewardConsumer().createReward(
                    reward,
                    widget.piggyCode,
                  );
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
