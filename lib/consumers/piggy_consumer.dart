import 'package:agattp/agattp.dart';
import 'package:piggywise_child_front/models/piggy.dart';
import 'package:piggywise_child_front/models/session.dart';
import 'package:piggywise_child_front/utils/config.dart';

///
///
///
class PiggyConsumer {
  ///
  ///
  ///
  Future<Piggy?> sync(final String code) async {
    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(<String>[Config().backUrl, 'piggies', 'sync', code].join('/')),
    );

    print(response.json);

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar os usuários da família');
    }

    return Piggy.fromJson(response.json);
  }

  ///
  ///
  ///
  Future<List<Piggy>> get getPiggies async {
    final AgattpResponseJson<List<dynamic>> response = await Agattp.authBasic(
      username: Session().user!.username,
      password: Session().user!.password,
    ).getJson(
      Uri.parse(<String>[Config().backUrl, 'piggies'].join('/')),
    );

    print(response.json);

    if (response.statusCode > 299 || response.statusCode < 200) {
      throw Exception('Falha ao resgatar os usuários da família');
    }

    final List<Piggy> piggies = <Piggy>[];
    for (final Map<String, dynamic> piggy in response.json) {
      piggies.add(Piggy.fromJson(piggy));
    }

    return piggies;
  }
}
