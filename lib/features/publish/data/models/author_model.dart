import 'package:code_connect_app/core/network/api_url.dart';
import 'package:code_connect_app/features/publish/domain/entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel({
    required super.id,
    required super.name,
    required super.username,
    required super.avatar,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatar: ApiUrl.resolve(json['avatar'] ?? ''),
    );
  }
}
