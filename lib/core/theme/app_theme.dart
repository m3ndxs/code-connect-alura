import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color verdeDestaque = Color(0xFF81FE88);
  static const Color verdePastel = Color(0xFFBFFFC3);
  static const Color verdePetroleo = Color(0xFF132E35);
  static const Color grafite = Color(0xFF01080E);
  static const Color cinzaEscuro = Color(0xFF171D1F);
  static const Color cinza = Color(0xFF3E3E3F);
  static const Color cinzaMedio = Color(0xFF888888);
  static const Color cinzaClaro = Color(0xFFBCBCBC);
  static const Color offWhite = Color(0xFFE1E1E1);

  static const Color white = Colors.white;

  // static const Color primary = Color(0xFF81FE88);
  // static const Color primaryLight = Color(0xFFBFFFC3);
  // static const Color secondary = Color(0xFF132E35);

  // static const Color background = Color(0xFF01080E);

  // static const Color dark = Color(0xFF171D1F);

  // static const Color grey = Color(0xFF3E3E3F);
  // static const Color greyMedium = Color(0xFF888888);
  // static const Color greyLight = Color(0xFFBCBCBC);

  // static const Color offWhite = Color(0xFFE1E1E1);
  // static const Color white = Colors.white;

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppTheme.grafite,
    colorScheme: const ColorScheme.dark(
      primary: AppTheme.verdeDestaque,
      secondary: AppTheme.verdePetroleo,
      surface: AppTheme.cinzaEscuro,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.grafite,
      foregroundColor: AppTheme.offWhite,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.verdeDestaque,
        foregroundColor: AppTheme.grafite,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTheme.cinzaEscuro,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headlineLarge: _cabecalho,
    headlineSmall: _cabecalho2,
    titleLarge: _subTituloGrande,
    titleMedium: _subTitulo,
    bodyLarge: _paragrafoGrande,
    bodyMedium: _paragrafo,
    bodySmall: _paragrafoPequeno,
    labelMedium: _label,
  );

  static final TextStyle _cabecalho = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 44,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static final TextStyle _cabecalho2 = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 37,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static final TextStyle _subTituloGrande = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 31,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle _subTitulo = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 26,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle _paragrafoGrande = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle _paragrafo = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle _paragrafoPequeno = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle _label = TextStyle(
    fontFamily: 'Prompt',
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
