import 'package:flutter/cupertino.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/views/balance_view.dart';
import 'package:piggywise_child_front/views/todo_list_view.dart';

///
///
///
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

///
///
///
class _HomeState extends State<Home> {
  final List<BottomNavigationBarItem> tabItems =
      const <BottomNavigationBarItem>[
    /// Balance
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.money_dollar_circle),
      label: 'Saldo',
    ),

    /// TO-DO List
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.square_list),
      label: 'Atividades',
    ),
  ];

  final List<Widget> pages = <Widget>[
    /// Balance
    const BalanceView(),

    /// TO-DO List
    const TodoListView(),
  ];

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: Utils().navBar(),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: tabItems),
        tabBuilder: (final BuildContext context, final int index) {
          return SafeArea(child: pages[index]);
        },
      ),
    );
  }
}
