import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.lightBackground,
      onPrimary: AppColors.lightOnPrimary,
      secondary: AppColors.commonPrimary,
      primaryContainer: AppColors.lightPrimaryVariant,
      inversePrimary: AppColors.lightInversePrimary,
    ),

    textTheme: AppTextStyles.lightTextTheme,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightAppBar,
      iconTheme: IconThemeData(color: AppColors.icon),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightAppBar,
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    canvasColor: Colors.black,
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkBackground,
      onPrimary: AppColors.darkOnPrimary,
      secondary: AppColors.commonPrimary,
      primaryContainer: AppColors.darkPrimaryVariant,
      inversePrimary: AppColors.darkInversePrimary,
    ),
    textTheme: AppTextStyles.darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      iconTheme: const IconThemeData(color: AppColors.icon),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightAppBar,
      foregroundColor: Colors.black,
    ),
  );
}
