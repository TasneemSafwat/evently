import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;

  void changeTheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }
}
