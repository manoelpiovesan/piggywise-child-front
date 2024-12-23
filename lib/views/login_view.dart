import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/user_consumer.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/config.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/home_view.dart';
import 'package:piggywise_child_front/views/signup_view.dart';
import 'package:piggywise_child_front/widgets/form_prefix.dart';
import 'package:random_avatar/random_avatar.dart';

///
///
///
class LoginView extends StatefulWidget {
  final String? message;

  ///
  ///
  ///
  const LoginView({super.key, this.message});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  User user = User();
  String? message;

  ///
  ///
  ///
  @override
  void initState() {
    message = widget.message;
    super.initState();
  }

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// Title
            Text(
              Config().appName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Subtitle
            Text(
              Config().slogan,
              style: const TextStyle(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
              ),
            ),
            Utils.spacer,

            /// Login Fields
            CupertinoFormSection.insetGrouped(
              children: <Widget>[
                /// Username
                CupertinoFormRow(
                  prefix: const FormPrefix(
                    icon: CupertinoIcons.person,
                    text: 'Usuário',
                  ),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Usuário',
                    prefix: user.username.isNotEmpty
                        ? RandomAvatar(user.username, width: 24, height: 24)
                        : null,
                    onChanged: (final String value) {
                      setState(() {
                        user.username = value;
                      });
                    },
                  ),
                ),

                /// Password
                CupertinoFormRow(
                  prefix: const FormPrefix(
                    icon: CupertinoIcons.lock,
                    text: 'Senha',
                  ),
                  child: CupertinoTextFormFieldRow(
                    placeholder: 'Senha',
                    obscureText: true,
                    onChanged: (final String value) {
                      user.password = value;
                    },
                  ),
                ),
              ],
            ),
            Utils.spacer,

            /// Message
            if (message != null)
              Text(
                message!,
                style: const TextStyle(color: CupertinoColors.systemGrey),
              ),
            if (message != null) Utils.spacer,

            /// Enter Button
            CupertinoButton.filled(
              onPressed: () => _login(context),
              child: const Text('Entrar'),
            ),

            /// Sign Up Button
            CupertinoButton(
              child: const Text('Cadastre-se'),
              onPressed: () => Utils.nav(context, const SignUpView()),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///
  ///
  Future<void> _login(final BuildContext context) async {
    try {
      await UserConsumer().login(user);

      if (context.mounted) {
        await Utils.navReplace(context, const HomeView());
      }
    } on Exception {
      setState(() {
        message = 'Falha no Login';
      });
    }
  }
}
