import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/user_consumer.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/views/home.dart';

///
///
///
class LoginView extends StatefulWidget {
  ///
  ///
  ///
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  User user = User();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// Login Fields
              CupertinoFormSection(
                children: <Widget>[
                  /// Username
                  CupertinoTextFormFieldRow(
                    placeholder: 'Usuário',
                    onChanged: (final String value) {
                      user.username = value;
                    },
                  ),

                  /// Password
                  CupertinoTextFormFieldRow(
                    placeholder: 'Senha',
                    obscureText: true,
                    onChanged: (final String value) {
                      user.password = value;
                    },
                  ),

                  /// Button
                  CupertinoButton.filled(
                    child: const Text('Entrar'),
                    onPressed: () async {
                      final bool success = await UserConsumer()
                          .login(user.username, user.password);

                      print("user.username: ${user.username}");
                      print("user.password: ${user.password}");

                      if (context.mounted) {
                        if (success) {
                          await Navigator.of(context).pushReplacement(
                            CupertinoPageRoute<void>(
                              builder: (final BuildContext context) =>
                                  const Home(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
