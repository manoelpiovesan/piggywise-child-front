import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/consumers/user_consumer.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/login_view.dart';
import 'package:random_avatar/random_avatar.dart';

///
///
///
class SignUpView extends StatefulWidget {
  ///
  ///
  ///
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  User user = User();

  bool _child = true;

  String exception = '';

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Registrar'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Utils.spacer,

              /// Random Avatar
              RandomAvatar(
                user.username.isEmpty ? 'PiggyWise' : user.username,
                width: 100,
                height: 100,
              ),

              /// Login Fields
              CupertinoFormSection.insetGrouped(
                header: const Text('Informações de Registro'),
                children: <Widget>[
                  /// Exception
                  if (exception.isNotEmpty)
                    Text(
                      exception,
                      style: const TextStyle(color: CupertinoColors.systemRed),
                    ),

                  /// Name
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.person),
                    placeholder: 'Primeiro Nome',
                    onChanged: (final String value) {
                      user.name = value;
                    },
                  ),

                  /// Username
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.person),
                    placeholder: 'Nome de Usuário',
                    onChanged: (final String value) {
                      setState(() {
                        user.username = value;
                      });
                    },
                  ),

                  /// Password
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.lock),
                    placeholder: 'Senha',
                    obscureText: true,
                    onChanged: (final String value) {
                      user.password = value;
                    },
                  ),
                ],
              ),
              _spacer,

              /// Parent or Child
              CupertinoSegmentedControl<int>(
                children: <int, Widget>{
                  0: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.child_care),
                        Utils.spacer,
                        const Text('Criança'),
                      ],
                    ),
                  ),
                  1: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.escalator_warning),
                        Utils.spacer,
                        const Text('Responsável'),
                      ],
                    ),
                  ),
                },
                groupValue: _child ? 0 : 1,
                onValueChanged: (final int value) {
                  setState(() {
                    _child = value == 0;
                  });
                },
              ),
              _spacer,

              /// Button
              CupertinoButton.filled(
                onPressed: () async => _login(context),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(final BuildContext context) async {
    try {
      if (_child) {
        await UserConsumer().createChild(user);
      } else {
        await UserConsumer().createParent(user);
      }

      if (context.mounted) {
        await Navigator.of(context).pushReplacement(
          CupertinoPageRoute<void>(
            builder: (final BuildContext context) => const LoginView(
              message: 'Criado com sucesso! Faça login para continuar.',
            ),
          ),
        );
      }
    } on Exception catch (e) {
      setState(() {
        exception = e.toString();
      });
    }
  }

  SizedBox get _spacer => const SizedBox(height: 16);
}
