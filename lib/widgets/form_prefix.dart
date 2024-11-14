import 'package:flutter/cupertino.dart';

///
///
///
class FormPrefix extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool optional;

  const FormPrefix({
    required this.icon,
    required this.text,
    super.key,
    this.optional = false,
  });

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) => Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(text),
              if (optional)
                const Text(
                  'Opcional',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      );
}
