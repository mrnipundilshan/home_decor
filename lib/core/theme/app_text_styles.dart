import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Light text theme
  static const TextTheme lightTextTheme = TextTheme(
    titleLarge: TextStyle(
      fontFamily: "Rubik",
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.lightTextPrimary,
    ),
    headlineSmall: TextStyle(
      fontFamily: "Rubik",
      fontSize: 18,
      fontWeight: FontWeight.w600,
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
    titleLarge: TextStyle(
      fontFamily: "Rubik",
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
    ),
    headlineSmall: TextStyle(
      fontFamily: "Rubik",
      fontSize: 18,
      fontWeight: FontWeight.w600,
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
