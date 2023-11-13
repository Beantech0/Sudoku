import 'package:flutter/material.dart';
import 'package:sudoku/screens/WelcomeScreen.dart';
import 'package:sudoku/screens/login.dart';

// Start App
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      initialRoute: 'WelcomeScreen',
      routes: {
        'WelcomeScreen': (context) => WelcomeScreen(),
        'Login':(context) => Login(),
      },
      debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
    );
  }

}