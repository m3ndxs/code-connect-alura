import 'package:code_connect_app/app.dart';
import 'package:code_connect_app/core/network/dio_client.dart';
import 'package:code_connect_app/core/providers/text_provider.dart';
import 'package:code_connect_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:code_connect_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:code_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/data/repositories/publish_repository_impl.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:code_connect_app/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: ((context) => di.sl<ProfileBloc>()))],
      child: const App(),
    ),

    // MultiProvider(
    //   providers: [
    //     Provider(create: (context) => DioClient()),
    //     Provider(
    //       create: (context) =>
    //           PublishRemoteDatasource(context.read<DioClient>().dio),
    //     ),
    //     Provider<PublishRepository>(
    //       create: (context) =>
    //           PublishRepositoryImpl(context.read<PublishRemoteDatasource>()),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) =>
    //           PublishProvider(context.read<PublishRepository>()),
    //     ),
    //     ChangeNotifierProvider(create: (_) => TextProvider()..load()),
    //     Provider(
    //       create: (context) =>
    //           ProfileRemoteDatasource(context.read<DioClient>().dio),
    //     ),
    //     Provider<ProfileRepository>(
    //       create: (context) =>
    //           ProfileRepositoryImpl(context.read<ProfileRemoteDatasource>()),
    //     ),
    //   ],
    //   child: const App(),
    // ),
  );
}
