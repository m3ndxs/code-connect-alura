import 'dart:convert';

import 'package:flutter/services.dart';

class AboutRepository {
  Future getAboutData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/texts.json',
    );

    final Map jsonMap = jsonDecode(jsonString);

    return jsonMap['about'];
  }
}
