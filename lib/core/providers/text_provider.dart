import 'package:code_connect_app/core/services/json_service.dart';
import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  final JsonService _service = JsonService();

  Map<String, dynamic> _texts = {};

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> load() async {
    _texts = await _service.loadTexts();
    _isLoading = false;
    notifyListeners();
  }

  String getText(String section, String key) {
    return _texts[section]?[key] ?? '';
  }
}
