import 'package:code_connect_app/core/network/dio_client.dart';
import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:code_connect_app/features/profile/domain/usecases/profile_use_case.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/data/repositories/publish_repository_impl.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:code_connect_app/features/publish/domain/usecase/post_publish_use_case.dart';
import 'package:code_connect_app/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Dio
  sl.registerLazySingleton(() => DioClient.instance);

  // Profile
  sl.registerFactory(() => ProfileBloc(profileUseCase: sl()));
  sl.registerLazySingleton(() => ProfileUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: sl()),
  );

  //Publish Post
  sl.registerFactory(() => PublishBloc(postPublishUseCase: sl()));
  sl.registerLazySingleton(() => PostPublishUseCase(sl()));
  sl.registerLazySingleton<PublishRepository>(
    () => PublishRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PublishRemoteDataSource>(
    () => PublishRemoteDataSourceImpl(dio: sl()),
  );
}
