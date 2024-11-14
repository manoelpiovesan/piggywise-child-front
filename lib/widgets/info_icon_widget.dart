import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/utils/utils.dart';

///
///
///
class InfoIconWidget extends StatelessWidget {
  final Icon icon;
  final String text;
  final String title;

  ///
  ///
  ///
  const InfoIconWidget({
    required this.icon,
    required this.text,
    required this.title,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(
    final BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          icon,
          Utils.spacer,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}
