import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

///
///
///
class Config {
  Config();

  Config._privateConstructor();

  static final Config _instance = Config._privateConstructor();

  static Config get instance => _instance;

  String backUrl = 'https://piggywise.com.br/api';

  String appName = 'PiggyWise';

  String slogan = 'O Cofre que Educa';

  final ValueNotifier<Brightness> _brightnessNotifier =
      ValueNotifier<Brightness>(Brightness.dark);

  ValueNotifier<Brightness> get brightnessNotifier => _brightnessNotifier;

  set brightness(final Brightness brightness) {
    _brightnessNotifier.value = brightness;
  }

  Brightness get brightness => _brightnessNotifier.value;
}
