import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sudoku/screens/Settings.dart';
import 'package:sudoku/screens/game_difficulty.dart';
import 'package:sudoku/screens/main_menu.dart';
import 'package:sudoku/screens/registration.dart';
import 'package:sudoku/screens/scoreboard.dart';
import 'package:sudoku/screens/welcome_screen.dart';
import 'package:sudoku/screens/game_table.dart';
import 'package:sudoku/screens/login.dart';
import 'package:sudoku/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

late SharedPreferences sharedPreferences;

// Start App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //local DB inicializálás
  await DatabaseHelper.instance.database;
  // SharedPreferences instance létrehozása
  sharedPreferences = await SharedPreferences.getInstance();
  bool isDarkMode = sharedPreferences.getBool('darkMode') ?? true;

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Sudoku');
      setWindowMaxSize(const Size(720, 1280));
      setWindowMinSize(const Size(720, 1280));
  }

  runApp(SudokuApp(isDarkMode: isDarkMode, prefs: sharedPreferences));
}

class SudokuApp extends StatelessWidget {
  final bool isDarkMode;
  final SharedPreferences prefs;
  const SudokuApp({Key? key, required this.isDarkMode, required this.prefs}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // final bool? isLoggedIn = sharedPreferences.getBool('IS_LOGGED_IN');
    return MaterialApp(
      restorationScopeId: "Test",
      initialRoute: '/WelcomeScreen',
      routes: {
        '/WelcomeScreen': (context) => const WelcomeScreen(),
        '/Login': (context) => const Login(),
        '/MainMenu': (context) => const MainMenu(),
        '/GameTable': (context) => const GameTable(
              difficultyLevel: null,
            ),
        '/Settings': (context) => const Settings(),
        '/GameDifficulty': (context) => const GameDifficulty(),
        '/Scoreboard': (context) => const Scoreboard(),
        '/Registration': (context) => const Registration(),
      },
      theme: isDarkMode ? ThemeData.dark(useMaterial3: false) : ThemeData.light( useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(), //kezdőoldal "/"
    );
  }
}
