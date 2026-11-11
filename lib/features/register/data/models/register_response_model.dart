import 'package:code_connect_app/features/register/data/models/register_entity_model.dart';
import 'package:code_connect_app/features/register/domain/entities/register_response_entity.dart';

class RegisterResponseModel extends RegisterResponseEntity {
  const RegisterResponseModel({
    required super.accessToken,
    required super.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      accessToken: json['access_token'] ?? '',
      user: RegisterEntityModel.fromJson(json['user'] ?? <String, dynamic>{}),
    );
  }
}
