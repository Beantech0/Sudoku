import 'package:flutter/material.dart';
import 'package:sudoku/screens/Settings.dart';
import 'package:sudoku/screens/main_menu.dart';
import 'package:sudoku/screens/welcome_screen.dart';
import 'package:sudoku/screens/game_table.dart';
import 'package:sudoku/screens/login.dart';

// Start App
void main() {
  runApp(const SudokuApp());
}

class SudokuApp extends StatelessWidget {
  const SudokuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      initialRoute: 'WelcomeScreen',
      routes: {
        'WelcomeScreen': (context) => WelcomeScreen(),
        'Login':(context) => Login(),
        'MainMenu': (context) => MainMenu(),
        'GameTable': (context) => GameTable(),
        'Settings': (context) => Settings(),
      },
      debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
    );
  }
}