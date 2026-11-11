import 'package:code_connect_app/features/register/domain/entities/register_entity.dart';
import 'package:equatable/equatable.dart';

class RegisterResponseEntity extends Equatable {
  final String accessToken;
  final RegisterEntity user;

  const RegisterResponseEntity({required this.accessToken, required this.user});

  @override
  List<Object> get props => [accessToken, user];
}
