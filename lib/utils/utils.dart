import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:piggywise_child_front/utils/config.dart';

///
///
///
class Utils {
  ///
  ///
  ///
  CupertinoNavigationBar navBar({
    final String? title,
    final Widget? trailing,
    final String? previousTitle,
  }) =>
      CupertinoNavigationBar(
        previousPageTitle: previousTitle,
        trailing: trailing,
        middle: title != null
            ? Text(title)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// Title
                      Text(Config().appName),

                      /// Subtitle
                      Text(
                        Config().slogan,
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      );

  ///
  ///
  ///
  static Future<void> navReplace(
    final BuildContext context,
    final Widget page,
  ) async {
    await Navigator.of(context).pushReplacement(
      CupertinoPageRoute<void>(
        builder: (final BuildContext context) => page,
      ),
    );
  }

  ///
  ///
  ///
  static Future<void> nav(
    final BuildContext context,
    final Widget page,
  ) async {
    await Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (final BuildContext context) => page,
      ),
    );
  }

  ///
  ///
  ///
  void showModal(
    final BuildContext context,
    final Widget page, {
    final double? height,
    final Color? color,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (final BuildContext context) => Container(
        decoration: BoxDecoration(color: color),
        width: MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.8,
        color: Config.instance.brightness == Brightness.light
            ? CupertinoColors.white
            : CupertinoColors.black,
        child: page,
      ),
    );
  }

  ///
  ///
  ///
  static SizedBox get spacer => const SizedBox(height: 16, width: 8);

  ///
  ///
  ///
  void alert(final BuildContext context, final String message) {
    showCupertinoDialog<void>(
      context: context,
      builder: (final BuildContext context) => CupertinoAlertDialog(
        title: const Text('Atenção'),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  void alertWidget(
    final BuildContext context,
    final Widget widget, {
    final String title = '',
    final String confirmText = 'Fechar',
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (final BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: widget,
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  static String formatDate(final DateTime? date) {
    if (date == null) {
      return '';
    }
    if (date.day == DateTime.now().day) {
      return 'hoje às ${DateFormat('HH:mm').format(date)}';
    }
    return DateFormat("dd/MM 'às' HH:mm").format(date);
  }

  ///
  ///
  ///
  static void get toggleTheme {
    Config.instance.brightness = Config.instance.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
  }
}
