import 'package:flutter/material.dart';
import '../main.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required this.isDark});
  bool isDark;

  void toggle() {
    isDark = !isDark;
    prefs.setBool('darkMode', isDark);
    notifyListeners();
  }
}
