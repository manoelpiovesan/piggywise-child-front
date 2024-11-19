import 'package:flutter/material.dart';

///
///
///
enum RewardStatus {
  available('Disponível', Icons.redeem),
  claimed('Resgatado', Icons.check_circle);

  final String translation;
  final IconData iconData;

  ///
  ///
  ///
  const RewardStatus(this.translation, this.iconData);

  ///
  ///
  ///
  static RewardStatus fromString(final String status) {
    switch (status) {
      case 'available':
        return RewardStatus.available;
      case 'claimed':
        return RewardStatus.claimed;
      default:
        return RewardStatus.available;
    }
  }
}
