// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/pages/settingspage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/homepage.dart';
import 'widgets/themes.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    _loadSettings();
  }

  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => 'Flutter szuper',
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter középhaladó',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(title: 'Flutter középhaladó'),
          '/settings': (context) => const SettingsPage()
        },
        theme: _darkMode == true ? darkTheme : lightTheme,
      ),
    );
  }

  void _loadSettings() async {
    _darkMode = prefs.getBool('darkMode') ?? false;
  }

  void _setThemeMode(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', darkMode);
  }
}
