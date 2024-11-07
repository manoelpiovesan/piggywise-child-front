import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///
///
class BalanceView extends StatefulWidget {
  const BalanceView({super.key});

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

///
///
///
class _BalanceViewState extends State<BalanceView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Balance
          const Row(
            children: <Widget>[
              /// Icon
              Icon(
                CupertinoIcons.money_dollar_circle,
                size: 60,
              ),

              SizedBox(width: 20),

              /// Values
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Saldo Atual'),
                  Text(
                    r'PG$ 1.200,00',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(r'A receber: PG$ 50,00'),
                ],
              ),
            ],
          ),

          /// TO-DO Preview
          CupertinoFormSection(
            backgroundColor: CupertinoColors.white,
            header: const Text('Próximas Atividades'),
            children: const <Widget>[
              /// 1
              CupertinoListTile(
                title: Text('Lavar a louça'),
                subtitle: Text('Cozinha'),
                leading: Icon(CupertinoIcons.check_mark_circled),
                trailing: CupertinoListTileChevron(),
              ),

              /// 2
              CupertinoListTile(
                title: Text('Arrumar a cama'),
                subtitle: Text('Quarto'),
                leading: Icon(CupertinoIcons.check_mark_circled),
                trailing: CupertinoListTileChevron(),
              ),

              /// See More
              CupertinoListTile(
                title: Text('Ver mais'),
                leading: Icon(CupertinoIcons.ellipsis),
                trailing: CupertinoListTileChevron(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
