import 'package:code_connect_app/app.dart';
import 'package:code_connect_app/core/network/dio_client.dart';
import 'package:code_connect_app/core/providers/text_provider.dart';
import 'package:code_connect_app/features/publish/data/datasource/publish_remote_datasource.dart';
import 'package:code_connect_app/features/publish/domain/repositories/publish_repository.dart';
import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => DioClient()),
        Provider(
          create: (context) =>
              PublishRemoteDatasource(context.read<DioClient>().dio),
        ),
        Provider<PublishRepository>(
          create: (context) => context.read<PublishRepository>(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              PublishProvider(context.read<PublishRepository>()),
        ),
        ChangeNotifierProvider(create: (_) => TextProvider()..load()),
      ],
      child: const App(),
    ),
  );
}
