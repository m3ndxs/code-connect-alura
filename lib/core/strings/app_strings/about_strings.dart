import 'package:code_connect_app/core/strings/texts.dart';

class AboutStrings {
  static final _get = Texts.scoped('about', 'about_page');

  static String get welcomeTitle => _get('welcomeTitle');
  static String get pageSubtitle => _get('pageSubtitle');
  static String get pageDescription => _get('pageDescription');
  static String get missionTitle => _get('missionTitle');
  static String get missionDescription => _get('missionDescription');
  static String get joinUsTitle => _get('joinUsTitle');
  static String get joinUsDescription => _get('joinUsDescription');
  static String get clossingMessage => _get('clossingMessage');
}
