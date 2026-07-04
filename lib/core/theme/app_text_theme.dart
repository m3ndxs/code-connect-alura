import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static final TextTheme textTheme = GoogleFonts.promptTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: AppColors.offWhite,
      ),
      displayMedium: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
      headlineMedium: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
      headlineSmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.offWhite,
      ),
    ),
  );
}
