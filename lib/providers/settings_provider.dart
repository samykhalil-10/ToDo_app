import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;


  void changeThemeMode(ThemeMode theme) {
    currentTheme = theme;
    saveTheme(theme);
    notifyListeners();
  }

  void saveTheme(ThemeMode currentTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentTheme == ThemeMode.light) {
      await prefs.setString("theme", "light");
    } else {
      await prefs.setString("theme", "dark");
    }
  }


  void getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString("theme") ?? "light";
    if (theme == "light") {
      currentTheme = ThemeMode.light;
    } else {
      currentTheme = ThemeMode.dark;
    }
    notifyListeners();
  }
}