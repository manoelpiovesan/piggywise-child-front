import 'package:flutter/cupertino.dart';

///
///
///
class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

///
///
///
class _TodoListViewState extends State<TodoListView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        /// TO-DO List
        CupertinoListSection(
          header: const Text('Atividades'),
          children: const <Widget>[
            /// 1
            CupertinoListTile(
              leading: Icon(CupertinoIcons.check_mark_circled),
              title: Text('Lavar a louça'),
              additionalInfo: Text(r'PG$ 10,00'),
              subtitle: Text('Cozinha | 10:00'),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              trailing: CupertinoListTileChevron(),
            ),

            /// 2
            CupertinoListTile(
              leading: Icon(CupertinoIcons.check_mark_circled),
              title: Text('Arrumar a cama'),
              additionalInfo: Text(r'PG$ 5,00'),
              subtitle: Text('Quarto | 10:30'),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              trailing: CupertinoListTileChevron(),
            ),

            /// 3
            CupertinoListTile(
              leading: Icon(CupertinoIcons.check_mark_circled),
              title: Text('Estudar'),
              additionalInfo: Text(r'PG$ 20,00'),
              subtitle: Text('Sala | 11:00'),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              trailing: CupertinoListTileChevron(),
            ),

            /// 4
            CupertinoListTile(
              leading: Icon(CupertinoIcons.check_mark_circled),
              title: Text('Fazer o dever de casa'),
              additionalInfo: Text(r'PG$ 15,00'),
              subtitle: Text('Sala | 14:00'),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              trailing: CupertinoListTileChevron(),
            ),
          ],
        ),
      ],
    );
  }
}
