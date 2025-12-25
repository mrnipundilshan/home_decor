import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/routes.dart';
import 'core/services/theme_service.dart';
import 'core/theme/app_theme.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp.router(
          routerConfig: appRouter,
          themeMode: themeService.isDarkModeOn
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}

