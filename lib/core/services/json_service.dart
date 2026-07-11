import 'dart:convert';

import 'package:flutter/services.dart';

class JsonService {
  Future<Map<String, dynamic>> loadTexts() async {
    final json = await rootBundle.loadString('assets/data/texts.json');
    return jsonDecode(json);
  }
}
