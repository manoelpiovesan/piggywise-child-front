import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/utils/utils.dart';

///
///
///
///
class InfoIconWidget extends StatelessWidget {
  final Widget icon;
  final String text;
  final String title;
  final bool reverse;

  ///
  ///
  ///
  const InfoIconWidget({
    required this.icon,
    required this.text,
    required this.title,
    this.reverse = false,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(
    final BuildContext context,
  ) {
    final List<Widget> children = <Widget>[
      icon,
      Utils.spacer,
      Column(
        crossAxisAlignment:
            reverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    ];

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CupertinoTheme.of(context).barBackgroundColor,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment:
              reverse ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: reverse ? children.reversed.toList() : children,
        ),
      ),
    );
  }
}
