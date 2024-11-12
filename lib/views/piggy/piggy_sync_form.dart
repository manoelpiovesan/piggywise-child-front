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
                onPressed: () async => syncPiggy(context),
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
  Future<void> syncPiggy(final BuildContext context) async {
    try {
      await PiggyConsumer().sync(_piggyCodeController.text);
      await Utils.navReplace(context, const HomeView());
    } on Exception catch (e) {
      if (context.mounted) {
        Utils().alert(context, e.toString());
      }
    }
  }
}
