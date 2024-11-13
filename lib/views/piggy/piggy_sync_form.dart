import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/home_view.dart';

///
///
///
class PiggySyncForm extends StatefulWidget {
  const PiggySyncForm({super.key});

  @override
  State<PiggySyncForm> createState() => _PiggySyncFormState();
}

///
///
///
class _PiggySyncFormState extends State<PiggySyncForm> {
  final TextEditingController _piggyCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: Utils().navBar(title: 'Sincronizar PiggyWise'),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CupertinoFormSection(
                children: <Widget>[
                  /// Name
                  CupertinoTextFormFieldRow(
                    controller: _nameController,
                    prefix: const Icon(Icons.chat_bubble),
                    placeholder: 'Escolha um nome para o Cofrinho',
                  ),

                  /// Description
                  CupertinoTextFormFieldRow(
                    controller: _descriptionController,
                    prefix: const Icon(Icons.description),
                    placeholder: 'Descrição do Cofrinho',
                  ),

                  /// Goal
                  CupertinoTextFormFieldRow(
                    controller: _goalController,
                    keyboardType: TextInputType.number,
                    prefix: const Icon(Icons.monetization_on_outlined),
                    placeholder: 'Meta do Cofrinho',
                  ),

                  /// Piggy Code
                  CupertinoTextFormFieldRow(
                    controller: _piggyCodeController,
                    prefix: const Icon(Icons.punch_clock_rounded),
                    placeholder: 'Código do PiggyWise',
                  ),
                ],
              ),
              Utils.spacer,
              CupertinoButton.filled(
                onPressed: () async => _syncPiggy(context),
                child: const Text('Sincronizar'),
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
  Future<void> _syncPiggy(final BuildContext context) async {
    try {
      await PiggyConsumer().sync(
        _piggyCodeController.text,
        _nameController.text,
        _descriptionController.text,
        int.parse(_goalController.text),
      );
      if (context.mounted) {
        await Utils.navReplace(context, const HomeView());
      }
    } on Exception catch (e) {
      if (context.mounted) {
        Utils().alert(context, e.toString());
      }
    }
  }
}
