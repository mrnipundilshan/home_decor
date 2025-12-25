import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Light text theme
  static const TextTheme lightTextTheme = TextTheme(
    headlineSmall: TextStyle(
      fontFamily: "Rubik",
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.lightTextPrimary,
    ),

    headlineLarge: TextStyle(
      fontFamily: "Rubik",
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: AppColors.lightTextPrimary,
    ),

    bodyMedium: TextStyle(
      fontFamily: "Rubik",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.lightTextPrimary,
    ),
  );

  // Dark text theme
  static const TextTheme darkTextTheme = TextTheme(
    headlineSmall: TextStyle(
      fontFamily: "Rubik",
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
    ),

    headlineLarge: TextStyle(
      fontFamily: "Rubik",
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
    ),

    bodyMedium: TextStyle(
      fontFamily: "Rubik",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.darkTextPrimary,
    ),
  );
}
