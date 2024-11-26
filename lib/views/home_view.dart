import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/family_widget.dart';
import 'package:piggywise_child_front/widgets/user_widget.dart';

///
///
///
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

///
///
///
class _HomeViewState extends State<HomeView> {
  Session session = Session();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      // navigationBar: Utils().navBar(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
          
              /// User
              UserWidget(),
          
              /// Family
              const FamilyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
