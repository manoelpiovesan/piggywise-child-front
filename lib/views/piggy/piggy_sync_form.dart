import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/home_view.dart';
import 'package:piggywise_child_front/widgets/form_prefix.dart';

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

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(title: 'Sincronizar PiggyWise'),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Utils.spacer,
              CupertinoFormSection.insetGrouped(
                children: <Widget>[
                  /// Name
                  CupertinoFormRow(
                    prefix: const FormPrefix(
                      icon: CupertinoIcons.person,
                      text: 'Nome',
                    ),
                    child: CupertinoTextFormFieldRow(
                      controller: _nameController,
                      placeholder: 'Escolha um nome para o seu Piggy',
                    ),
                  ),

                  /// Description
                  CupertinoFormRow(
                    prefix: const FormPrefix(
                      icon: CupertinoIcons.text_bubble,
                      text: 'Descrição',
                      optional: true,
                    ),
                    child: CupertinoTextFormFieldRow(
                      controller: _descriptionController,
                      placeholder: 'Descrição do Cofrinho',
                    ),
                  ),

                  /// Piggy Code
                  CupertinoFormRow(
                    prefix: const FormPrefix(
                      icon: CupertinoIcons.qrcode,
                      text: 'Código',
                    ),
                    child: CupertinoTextFormFieldRow(
                      controller: _piggyCodeController,
                      placeholder: 'Código do PiggyWise',
                    ),
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
