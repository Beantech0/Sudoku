import 'package:flutter/material.dart';
import 'package:sudoku/screens/Settings.dart';
import 'package:sudoku/screens/game_difficulty.dart';
import 'package:sudoku/screens/main_menu.dart';
import 'package:sudoku/screens/welcome_screen.dart';
import 'package:sudoku/screens/game_table.dart';
import 'package:sudoku/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; //több nyelv támogatása
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
// Start App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SudokuApp());
}

bool? _darkMode; //Lehet nullable
ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
    ));
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
);

class SudokuApp extends StatelessWidget {
  SudokuApp({Key? key}) : super(key: key) {
    setTheme(true);
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('hu'), // Hungary
      ],
      initialRoute: '/WelcomeScreen',
      routes: {
        '/WelcomeScreen': (context) => const WelcomeScreen(),
        '/Login': (context) => const Login(),
        '/MainMenu': (context) => const MainMenu(),
        '/GameTable': (context) => const GameTable(
              difficultyLevel: null,
            ),
        '/Settings': (context) => const Settings(),
        '/GameDifficulty': (context) => const GameDifficulty()
      },
      theme: _darkMode == false ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(), //kezdőoldal "/"
    );
  }

  void _loadSettings() async {
    _darkMode = prefs.getBool('darkMode') ?? false;
  }

  void setTheme(bool darkMode) async {
    prefs.setBool('darkMode', darkMode);
  }
}
