import 'package:code_connect_app/core/strings/texts.dart';

class PublishStrings {
  static final _get = Texts.scoped('publish', 'publish_page');

  static String get newProject => _get('newProject');
  static String get nameProject => _get('nameProject');
  static String get description => _get('description');
  static String get tags => _get('tags');
  static String get buttonDiscard => _get('buttonDiscard');
  static String get buttonPublish => _get('buttonPublish');
  static String get buttonUploadImage => _get('buttonUploadImage');
}
