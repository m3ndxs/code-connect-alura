import 'package:code_connect_app/features/profile/domain/entities/user_entity.dart';
import 'package:code_connect_app/features/profile/domain/usecases/profile_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileBloc({required this.profileUseCase}) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final result = await profileUseCase();
      result.fold(
        (failure) {
          emit(ProfileFailure(failure.message));
        },
        (user) {
          emit(ProfileSuccess(user));
        },
      );
    } catch (e) {
      emit(ProfileFailure('Erro interno no App: $e'));
    }
  }
}
