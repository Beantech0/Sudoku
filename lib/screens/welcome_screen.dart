
import 'package:flutter/material.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';
import 'package:sudoku/widgets/inputFields.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  // final String _loginImagePath = 'images/sudoku_logo_transparent.png';
  final String _loginImagePath = 'images/calculator-icon.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Form(
            child: ListView(
          children: [
            loginImage(_loginImagePath),
            inputTextField('/Login'),
            buttonPushNamed('Login', context, '/Login'),
            buttonPushNamed('Play without Login', context, '/MainMenu'),
            buttonQuit('Quit', context),
          ],
        )),
      ),
    );
  }
}




