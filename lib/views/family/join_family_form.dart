import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/family_consumer.dart';
import 'package:piggywise_child_front/models/family.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/form_prefix.dart';
import 'package:qrcode_reader_web/qrcode_reader_web.dart';

///
///
///
class JoinFamilyForm extends StatefulWidget {
  const JoinFamilyForm({super.key});

  @override
  State<JoinFamilyForm> createState() => _JoinFamilyFormState();
}

///
///
///
class _JoinFamilyFormState extends State<JoinFamilyForm> {
  final TextEditingController _familyCodeController = TextEditingController();
  bool readed = false;

  String? message;

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(title: 'Entrar em uma família'),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Utils.spacer,

              /// QrCode
              if (!readed)
                QRCodeReaderSquareWidget(
                  onDetect: (final QRCodeCapture capture) async {
                    setState(() {
                      _familyCodeController.text = capture.raw;
                      readed = true;
                    });
                  },
                  size: 250,
                ),

              /// Form
              CupertinoFormSection.insetGrouped(
                children: <Widget>[
                  /// Family Code
                  CupertinoFormRow(
                    prefix: const FormPrefix(
                      icon: CupertinoIcons.group_solid,
                      text: 'Código da Família',
                    ),
                    child: CupertinoTextFormFieldRow(
                      placeholder: 'Código da Família',
                      controller: _familyCodeController,
                    ),
                  ),
                ],
              ),
              Utils.spacer,

              if (message != null)
                Text(
                  message!,
                  style: const TextStyle(color: CupertinoColors.systemRed),
                ),
              if (message != null) Utils.spacer,

              /// Button
              CupertinoButton.filled(
                child: const Text('Entrar'),
                onPressed: () =>
                    _joinFamily(context, _familyCodeController.text),
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
  Future<void> _joinFamily(
    final BuildContext context,
    final String code,
  ) async {
    final Family? family =
        await FamilyConsumer().joinFamily(_familyCodeController.text);

    print('Codigo encontrado: $code');

    if (family != null) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        message = 'Código de família inválido';
      });
    }
  }
}
