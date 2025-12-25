import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'isDarkModeOn';

  bool isDarkModeOn = false;

  ThemeService() {
    _loadTheme();
  }

  // load theme from shared preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkModeOn = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  // toggle and save theme
  Future<void> toggleTheme() async {
    isDarkModeOn = !isDarkModeOn;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkModeOn);
    notifyListeners();
  }
}
