import 'package:code_connect_app/app.dart';
import 'package:code_connect_app/core/providers/text_provider.dart';
import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextProvider()..load()),
        ChangeNotifierProvider(create: (_) => PublishProvider()),
      ],
      child: const App(),
    ),
  );
}
