import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String accessToken;
  final UserEntity user;

  const AuthEntity({required this.accessToken, required this.user});

  @override
  List<Object> get props => [accessToken, user];
}

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserEntity({required this.id, required this.email, required this.name});

  @override
  List<Object> get props => [id, email, name];
}
