import 'package:flutter/cupertino.dart';

///
///
///
class ListTileNoDataYet extends StatelessWidget {
  final String title;
  final Widget trailing;
  final String? subtitle;
  final VoidCallback? onTap;
  final Icon icon;

  ///
  ///
  ///
  const ListTileNoDataYet({
    required this.title,
    required this.icon,
    this.trailing = const CupertinoListTileChevron(),
    super.key,
    this.onTap,
    this.subtitle,
  });

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) => CupertinoListTile(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        leading: icon,
        subtitle: subtitle == null ? null : Text(subtitle!),
        title: Text(title),
        trailing: trailing,
      );
}
