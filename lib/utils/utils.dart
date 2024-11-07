import 'package:flutter/cupertino.dart';

///
///
///
class Utils {
  ///
  ///
  ///
  CupertinoNavigationBar navBar({final String? title}) =>
      CupertinoNavigationBar(
        middle: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// Icon
            const Image(
              image: AssetImage('assets/images/piggy1.png'),
              width: 40,
            ),

            /// Title
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// Title
                Text(title ?? 'PiggyWise'),

                /// Subtitle
                const Text(
                  'Para Crianças',
                  style: TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
