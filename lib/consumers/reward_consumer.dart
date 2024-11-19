import 'package:agattp/agattp.dart';
import 'package:piggywise_child_front/models/reward.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/utils/config.dart';

///
///
///
class RewardConsumer {
  ///
  ///
  /// Create
  Future<Reward?> createReward(
    final Reward reward,
    final String piggyCode,
  ) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).postJson(
      Uri.parse('${<String>[
        Config().backUrl,
        'rewards',
      ].join('/')}?piggyCode=$piggyCode'),
      body: reward.toMap(),
    );



    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar o reward');
    }

    return Reward.fromJson(response.json);
  }

  ///
  ///
  /// Claim
  Future<Reward?> claimReward(final int rewardId) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(
        <String>[
          Config().backUrl,
          'rewards',
          rewardId.toString(),
          'claim',
        ].join('/'),
      ),
    );


    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar o reward');
    }

    return Reward.fromJson(response.json);
  }
}
