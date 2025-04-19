import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  String languageCode = 'en';
  bool get isDark => themeMode == ThemeMode.dark;

  void changeTheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }

  void changeLanguage(String language) {
    languageCode = language;
    notifyListeners();
  }
}
