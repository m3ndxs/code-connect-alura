import 'package:code_connect_app/features/auth/domain/entities/auth_entity.dart';

class LoginResponseModel extends AuthEntity {
  const LoginResponseModel({required super.accessToken, required super.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'] ?? '',
      user: UserModel.fromJson(json['user'] ?? <String, dynamic>{}),
    );
  }
}

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
