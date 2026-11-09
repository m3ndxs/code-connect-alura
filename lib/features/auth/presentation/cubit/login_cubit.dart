import 'package:code_connect_app/features/auth/domain/usecase/login_use_case.dart';
import 'package:code_connect_app/features/auth/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase usecase;

  LoginCubit({required this.usecase}) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    if (state is LoginLoading) return;

    emit(const LoginLoading());

    try {
      final result = await usecase(email: email, password: password);

      result.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (auth) => emit(LoginSuccess(auth)),
      );
    } catch (e) {
      emit(const LoginFailure('Não foi possível realizar o login.'));
    }
  }
}
