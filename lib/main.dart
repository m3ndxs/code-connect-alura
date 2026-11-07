import 'package:code_connect_app/app.dart';
import 'package:code_connect_app/core/strings/texts.dart';
import 'package:code_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:code_connect_app/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_connect_app/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Texts.load();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => di.sl<ProfileBloc>())),
        BlocProvider(create: ((context) => di.sl<PublishBloc>())),
      ],
      child: const App(),
    ),
  );
}
