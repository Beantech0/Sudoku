import 'package:flutter/material.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';

class MainMenu extends StatelessWidget {
  // final String _loginImagePath = 'images/sudoku_logo_transparent.png';
      final String _loginImagePath = 'images/calculator-icon.png';
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Form(
            child: ListView(
          children: [
            loginImage(_loginImagePath),
            buttonPushNamed('New Game', context, '/GameDifficulty'),
            buttonPushNamed('Settings', context, '/Settings'),

          ],
        )),
      ),
    );
  }
}
