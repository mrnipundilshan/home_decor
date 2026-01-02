import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'core/routes/routes.dart';
import 'core/services/theme_service.dart';
import 'core/services/locale_service.dart';
import 'core/theme/app_theme.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LocaleService>(
      builder: (context, themeService, localeService, child) {
        // Use 'en' for MaterialApp locale when 'si' is selected (since Flutter doesn't support 'si')
        // Our custom translation system will still use 'si' from LocaleService
        final materialAppLocale = localeService.currentLocale == 'si'
            ? const Locale('en', '')
            : Locale(localeService.currentLocale);

        return MaterialApp.router(
          routerConfig: appRouter,
          locale: materialAppLocale,
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('si', ''), // Sinhala (for our custom translations)
          ],
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
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
