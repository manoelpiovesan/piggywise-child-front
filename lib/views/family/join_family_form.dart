import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  bool read = false;
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
          child: read
              ? Column(
                  children: <Widget>[
                    Utils.spacer,

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
                        style:
                            const TextStyle(color: CupertinoColors.systemRed),
                      ),
                    if (message != null) Utils.spacer,

                    /// Button
                    CupertinoButton.filled(
                      child: const Text('Entrar'),
                      onPressed: () =>
                          _joinFamily(context, _familyCodeController.text),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Utils.spacer,
                    QRCodeReaderSquareWidget(
                      onDetect: (final QRCodeCapture capture) async {
                        setState(() {
                          _familyCodeController.text = capture.raw;
                          read = true;
                        });

                        await _joinFamily(context, capture.raw);
                      },
                      size: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Utils.spacer,
                    CupertinoButton.filled(
                      onPressed: () => setState(() {
                        read = true;
                      }),
                      child: const Text('Inserir manualmente'),
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
        await FamilyConsumer().join(_familyCodeController.text);

    if (kDebugMode) {
      print('Codigo encontrado: $code');
    }

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
