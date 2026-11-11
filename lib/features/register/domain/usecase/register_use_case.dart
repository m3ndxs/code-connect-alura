import 'package:code_connect_app/core/errors/failures.dart';
import 'package:code_connect_app/features/register/domain/entities/register_response_entity.dart';
import 'package:code_connect_app/features/register/domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, RegisterResponseEntity>> call(ParamsRegister params) {
    return repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class ParamsRegister extends Equatable {
  final String email;
  final String password;
  final String name;

  const ParamsRegister({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}
