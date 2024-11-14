// ignore_for_file: constant_identifier_names, document_ignores

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///
///
enum TaskStatus {
  pending(
    color: CupertinoColors.systemYellow,
    iconData: CupertinoIcons.clock,
    translation: 'Pendente',
  ),
  in_progress(
    color: CupertinoColors.systemBlue,
    iconData: CupertinoIcons.play_arrow,
    translation: 'Em Progresso',
  ),
  waiting_approval(
    color: CupertinoColors.systemOrange,
    iconData: CupertinoIcons.hourglass,
    translation: 'Aguardando Aprovação',
  ),
  waiting_deposit(
    color: CupertinoColors.systemOrange,
    iconData: Icons.currency_exchange,
    translation: 'Aguardando Depósito',
  ),
  done(
    color: CupertinoColors.systemGreen,
    iconData: CupertinoIcons.check_mark,
    translation: 'Concluído',
  );

  final Color color;
  final IconData iconData;
  final String translation;

  ///
  ///
  ///
  const TaskStatus({
    required this.color,
    required this.iconData,
    required this.translation,
  });

  ///
  ///
  ///
  static TaskStatus fromString(final String status) {
    switch (status) {
      case 'pending':
        return TaskStatus.pending;
      case 'in_progress':
        return TaskStatus.in_progress;
      case 'waiting_approval':
        return TaskStatus.waiting_approval;
      case 'waiting_deposit':
        return TaskStatus.waiting_deposit;
      case 'done':
        return TaskStatus.done;
      default:
        return TaskStatus.pending;
    }
  }

  ///
  ///
  ///
  Icon get iconColored => Icon(iconData, color: color);

  ///
  ///
  ///
  Icon get icon => Icon(iconData);
}
