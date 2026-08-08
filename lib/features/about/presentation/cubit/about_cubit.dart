import 'package:code_connect_app/features/about/presentation/cubit/about_state.dart';
import 'package:code_connect_app/features/about/repositories/about_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutCubit extends Cubit<AboutState> {
  final AboutRepository repository;

  AboutCubit(this.repository) : super(AboutInitial());

  Future loadAboutData() async {
    emit(AboutLoading());

    try {
      final data = await repository.getAboutData();
      emit(AboutLoaded(data));
    } catch (e) {
      emit(AboutError("Erro ao carregar as informações."));
    }
  }
}
