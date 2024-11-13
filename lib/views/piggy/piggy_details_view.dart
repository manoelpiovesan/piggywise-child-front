import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:piggywise_child_front/consumers/piggy_consumer.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/utils/utils.dart';
import 'package:piggywise_child_front/widgets/hideable_code_widget.dart';
import 'package:piggywise_child_front/widgets/task_list_widget.dart';

///
///
///
class PiggyDetailsView extends StatefulWidget {
  final String? previousTitle;
  final int piggyId;

  const PiggyDetailsView({
    required this.piggyId,
    super.key,
    this.previousTitle,
  });

  @override
  State<PiggyDetailsView> createState() => _PiggyDetailsViewState();
}

///
///
///
class _PiggyDetailsViewState extends State<PiggyDetailsView> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: Utils().navBar(
        previousTitle: widget.previousTitle,
        title: 'Cofrinho',
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            'Editar',
          ),
          onPressed: () {},
        ),
      ),
      child: FutureBuilder<Piggy?>(
        future: PiggyConsumer().getById(widget.piggyId),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<Piggy?> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            final Piggy piggy = snapshot.data!;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /// Details
                    _details(piggy),

                    /// Tasks
                    TaskListWidget(piggyId: piggy.id),

                    /// More info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /// Title
                            const Text(
                              'Nome',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),

                            /// Family Name
                            Text(
                              piggy.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        /// Family Code
                        HideableCodeWidget(
                          code: piggy.code,
                          bordered: false,
                          title: 'Código de Sincronização',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  ///
  ///
  ///
  Widget _details(final Piggy piggy) => Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[

            Utils.spacer,

            /// Piggy Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /// Balance
                Column(
                  children: <Widget>[
                    /// Title
                    const Text(
                      'Saldo Atual',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

                    /// Balance
                    Text(
                      '${piggy.balance}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// Waiting deposit
                    Text(
                      '+ ${piggy.waitingDeposit} aguardando depósito.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),

                /// Goal
                Column(
                  children: <Widget>[

                    /// Percentage
                    CircularPercentIndicator(
                      radius: 50,
                      lineWidth: 10,
                      percent: piggy.progress,
                      linearGradient: const LinearGradient(
                        colors: <Color>[
                          Colors.blue,
                          Colors.purple,
                        ],
                      ),
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '${(piggy.progress * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            piggy.goal.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),

            Utils.spacer,


          ],
        ),
      );
}
