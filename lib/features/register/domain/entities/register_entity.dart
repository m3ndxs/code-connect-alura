import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String id;
  final String email;
  final String name;

  const RegisterEntity({
    required this.id,
    required this.email,
    required this.name,
  });

  @override
  List<Object> get props => [id, email, name];
}
