import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/consumers/user_consumer.dart';
import 'package:piggywise_child_front/models/user.dart';
import 'package:piggywise_child_front/utils/config.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/home_view.dart';
import 'package:piggywise_child_front/views/signup_view.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _spacer,
              _spacer,

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
              _spacer,

              /// Login Fields
              CupertinoFormSection.insetGrouped(
                children: <Widget>[
                  /// Username
                  CupertinoTextFormFieldRow(
                    prefix: const Icon(CupertinoIcons.person),
                    placeholder: 'Usuário',
                    onChanged: (final String value) {
                      user.username = value;
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

              /// Message
              if (message != null)
                Text(
                  message!,
                  style: const TextStyle(color: CupertinoColors.systemOrange),
                ),
              _spacer,

              /// Enter Button
              CupertinoButton.filled(
                onPressed: () => _login(context),
                child: const Text('Entrar'),
              ),

              /// Sign Up Button
              CupertinoButton(
                child: const Text('Registrar'),
                onPressed: () => Utils.nav(context, const SignUpView()),
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

  ///
  ///
  ///
  SizedBox get _spacer => const SizedBox(height: 16);
}
