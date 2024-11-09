///
///
///
class Config {

  Config();
  Config._privateConstructor();

  static final Config _instance = Config._privateConstructor();

  static Config get instance => _instance;

  String backUrl = 'http://localhost:8080';

  String appName = 'PiggyWise';

  String slogan = 'O Cofre que Educa';
}
