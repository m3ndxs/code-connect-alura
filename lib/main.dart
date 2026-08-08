import 'package:code_connect_app/app.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
