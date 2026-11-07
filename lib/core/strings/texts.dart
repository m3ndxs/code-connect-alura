import 'dart:convert';

import 'package:code_connect_app/core/strings/text_flow.dart';
import 'package:code_connect_app/core/strings/text_page.dart';
import 'package:flutter/services.dart';

abstract final class Texts {
  static Map<String, dynamic> _strings = {};
  static bool _isLoaded = false;

  static Future<void> load() async {
    const assetPath = 'lib/core/assets/strings/strings_pt_BR.json';

    final jsonString = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(jsonString);

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
        'A raiz do arquivo de strings deve ser um objeto JSON.',
      );
    }

    _strings = decoded;
    _isLoaded = true;
  }

  static String getText(
    TextFlow flow,
    TextPage page,
    String id, {
    Map<String, String> params = const {},
  }) {
    if (!_isLoaded) {
      throw StateError(
        'O sistema de Strings não for carregado. '
        'Execute await Text.load() antes de runApp().',
      );
    }

    final flowKey = flow.name;
    final pageKey = page.key;

    final text = _strings[flowKey]?[pageKey]?[id];

    if (text is! String) {
      throw StateError('Texto não encontrado : $flowKey.$pageKey.$id');
    }

    return _interpolate(text, params);
  }

  static String _interpolate(String text, Map<String, String> params) {
    return text.replaceAllMapped(RegExp(r'\{(\w+)\}'), (match) {
      final key = match.group(1)!;

      return params[key] ?? match.group(0)!;
    });
  }

  static String Function(String id, {Map<String, String>? params}) scoped(
    String flow,
    String page,
  ) {
    return (id, {params}) {
      return _getByKey(flow, page, id, params: params);
    };
  }

  static String _getByKey(
    String flowKey,
    String pageKey,
    String id, {
    Map<String, String>? params,
  }) {
    if (!_isLoaded) {
      throw StateError(
        'O sistema de strings não foi carregado. '
        'Execute await Texts.load() antes de runApp().',
      );
    }

    final text = _strings[flowKey]?[pageKey]?[id];

    if (text is! String) {
      throw StateError('Texto não encontrado: $flowKey.$pageKey.$id');
    }

    return _interpolate(text, params ?? const {});
  }
}
