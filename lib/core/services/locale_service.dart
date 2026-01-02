import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  static const String _localeKey = 'selectedLocale';

  String currentLocale = 'en'; // Default to English

  LocaleService() {
    _loadLocale();
  }

  // load locale from shared preferences
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    currentLocale = prefs.getString(_localeKey) ?? 'en';
    notifyListeners();
  }

  // set and save locale
  Future<void> setLocale(String localeCode) async {
    if (currentLocale != localeCode) {
      currentLocale = localeCode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, localeCode);
      notifyListeners();
    }
  }

  // toggle between English and Sinhala
  Future<void> toggleLocale() async {
    currentLocale = currentLocale == 'en' ? 'si' : 'en';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, currentLocale);
    notifyListeners();
  }
}
