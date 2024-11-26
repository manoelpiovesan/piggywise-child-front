import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/utils/config.dart';
import 'package:piggywise_child_front/views/login_view.dart';

///
///
///
void main() {
  runApp(const MyApp());
}

///
///
///
class MyApp extends StatelessWidget {
  ///
  ///
  ///
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return ValueListenableBuilder<Brightness>(
      valueListenable: Config.instance.brightnessNotifier,
      builder: (
        final BuildContext context,
        final Brightness brightness,
        final Widget? child,
      ) {
        return CupertinoApp(
          theme: CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
            brightness: brightness,
          ),
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        );
      },
    );
  }
}
