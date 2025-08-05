import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  ThemeData _themeData;

  ThemeProvider(this.prefs) : _themeData = _getThemeFromPrefs(prefs);

  ThemeData getTheme() => _themeData;

  bool get isDarkMode => _themeData.brightness == Brightness.dark;

  static ThemeData _getThemeFromPrefs(SharedPreferences prefs) {
    final theme = prefs.getString('theme') ?? 'light';
    return theme == 'light' ? _lightTheme : _darkTheme;
  }

  static ThemeData get _lightTheme => ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    useMaterial3: true,
  );

  static ThemeData get _darkTheme => ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    useMaterial3: true,
  );

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    final themeString = themeData.brightness == Brightness.light ? 'light' : 'dark';
    prefs.setString('theme', themeString);
    notifyListeners();
  }

  void toggleTheme() {
    final newTheme = _themeData.brightness == Brightness.light ? _darkTheme : _lightTheme;
    setTheme(newTheme);
  }
}