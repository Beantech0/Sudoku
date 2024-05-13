import 'package:flutter/material.dart';
import 'package:sudoku/screens/Settings.dart';
import 'package:sudoku/screens/game_difficulty.dart';
import 'package:sudoku/screens/main_menu.dart';
import 'package:sudoku/screens/welcome_screen.dart';
import 'package:sudoku/screens/game_table.dart';
import 'package:sudoku/screens/login.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; //több nyelv támogatása
import 'package:shared_preferences/shared_preferences.dart';

// Start App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('darkMode') ?? true;
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(SudokuApp(isDarkMode: isDarkMode, prefs: prefs));
}

class SudokuApp extends StatelessWidget {
  final bool isDarkMode;
  final SharedPreferences prefs;
  const SudokuApp({Key? key, required this.isDarkMode, required this.prefs}) : super(key: key);
  
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
      theme: isDarkMode ? ThemeData.dark(useMaterial3: false) : ThemeData.light( useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(), //kezdőoldal "/"
    );
  }
}

