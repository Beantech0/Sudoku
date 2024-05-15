
import 'package:flutter/material.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    // _initDatabase();
  }
  final String _loginImagePath = 'images/sudoku_logo_transparent.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          child: ListView(
        children: [
          loginImage(_loginImagePath),
          buttonPushNamed('Login', context, '/Login'),
          buttonPushNamed('Play without Login', context, '/MainMenu'),
          buttonQuit('Quit', context),
        ],
      )),
    );
  }
}




