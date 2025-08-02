import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/pages/managetodo.dart';
import 'package:flutter_kozephalado/pages/settingspage.dart';
import 'package:flutter_kozephalado/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/homepage.dart';
import 'providers/selected_todo_provider.dart';
import 'providers/todo_provider.dart';
import 'widgets/themes.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider()..loadSettings()),
        ChangeNotifierProvider<TodoProvider>(
            create: (_) => TodoProvider()..selectAll()),
        ChangeNotifierProvider<SelectedTodoProvider>(
            create: (_) => SelectedTodoProvider()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter középhaladó',
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(title: ''),
            '/settings': (context) => const SettingsPage(),
            '/insertTodo': (context) => const ManageTodo(title: 'Insert todo'),
            '/updateTodo': (context) => const ManageTodo(title: 'Update todo')
          },
          theme: Provider.of<ThemeProvider>(context).isDark
              ? darkTheme
              : lightTheme,
        );
      }),
    );
  }
}
