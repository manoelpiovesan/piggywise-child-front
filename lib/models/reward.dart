import 'package:piggywise_child_front/enums/reward_status.dart';
import 'package:piggywise_child_front/models/user.dart';

///
///
///
class Reward {
  int id = -1;
  String name = '';
  String? description;
  int points = 0;
  RewardStatus status = RewardStatus.available;
  User? claimedBy;

  ///
  ///
  ///
  Reward();

  ///
  ///
  ///
  Reward.fromJson(final Map<String, dynamic> map) {
    id = map['id'] ?? -1;
    name = map['name'] ?? '';
    description = map['description'] ?? '';
    points = map['points'] ?? 0;
    status = RewardStatus.fromString(map['status'] ?? 'available');
    map['claimedBy'] != null
        ? claimedBy = User.fromJson(map['claimedBy'])
        : claimedBy = null;
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'status': status.toString(),
      'claimedBy': claimedBy?.toMap(),
    };
  }
}
