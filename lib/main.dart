// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/pages/settingspage.dart';
import 'package:flutter_kozephalado/providers/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/homepage.dart';
import 'widgets/themes.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(isDark: false)),
        Provider(create: (context) => 'Flutter szuper')
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter középhaladó',
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(title: 'Flutter középhaladó'),
            '/settings': (context) => const SettingsPage()
          },
          theme: Provider.of<ThemeProvider>(context).isDark
              ? darkTheme
              : lightTheme,
        );
      }),
    );
  }
}
