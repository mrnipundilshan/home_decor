import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/app_translations.dart';
import 'package:home_decor/core/services/locale_service.dart';
import 'package:provider/provider.dart';

extension TranslationExtension on BuildContext {
  String translate(String key) {
    final localeService = Provider.of<LocaleService>(this, listen: true);
    return AppTranslations.translate(localeService.currentLocale, key);
  }
}
