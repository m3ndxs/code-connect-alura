import 'package:code_connect_app/core/network/dio_client.dart';
import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:code_connect_app/features/profile/domain/usecases/profile_use_case.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => ProfileBloc(profileUseCase: sl()));
  sl.registerLazySingleton(() => ProfileUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton(() => DioClient.instance);
}
