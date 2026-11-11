import 'package:code_connect_app/features/register/domain/entities/register_entity.dart';

class RegisterEntityModel extends RegisterEntity {
  const RegisterEntityModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory RegisterEntityModel.fromJson(Map<String, dynamic> json) {
    return RegisterEntityModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
