import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/utils/config.dart';
import 'package:piggywise_child_front/utils/utils.dart';

///
///
///
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

///
///
///
class _SettingsViewState extends State<SettingsView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(title: 'Configurações'),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            /// Configurations
            CupertinoFormSection.insetGrouped(
              header: const Text('Configurações'),
              children: <Widget>[
                /// DarkMode
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.moon_fill),
                  title: const Text('Modo Escuro'),
                  trailing: CupertinoSwitch(
                    value: Config.instance.brightness == Brightness.dark,
                    onChanged: (final _) {
                      Utils.toggleTheme;
                      setState(() {});
                    },
                  ),
                ),

                /// Logout
                CupertinoListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: CupertinoColors.systemRed,
                  ),
                  title: const Text('Sair'),
                  onTap: () => Session.logout(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
