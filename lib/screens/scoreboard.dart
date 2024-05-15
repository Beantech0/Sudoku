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
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Form(
            child: ListView(
          children: [
            loginImage(_loginImagePath),
            buttonPushNamed('Test', context, '/GameTable'),
            buttonPushNamed('Easy', context, '/GameTable'),
            buttonPushNamed('Medium', context, '/GameTable'),
            buttonPushNamed('Hard', context, '/GameTable'),
          ],
        )),
      ),
    );
  }
}
