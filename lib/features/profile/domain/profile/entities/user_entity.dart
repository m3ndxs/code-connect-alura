import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String username;
  final String avatar;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.avatar,
  });

  @override
  List<Object> get props => [id, email, name, username, avatar];
}
