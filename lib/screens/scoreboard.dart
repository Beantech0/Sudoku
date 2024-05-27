import 'package:flutter/material.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';

class Scoreboard extends StatelessWidget {
  final String _loginImagePath = 'images/sudoku_logo_transparent.png';

  const Scoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Form(
            child: ListView(
          children: [
            loginImage(_loginImagePath),
          ],
        )),
      ),
    );
  }
}
