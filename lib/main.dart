import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piggywise_child_front/views/home.dart';

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

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
