import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required this.isDark}) {
    Future.delayed(const Duration(seconds: 5), () {
      _loadSettings();
    });
  }
  bool isDark;

  void toggle() async {
    isDark = !isDark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', isDark);
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }
}
