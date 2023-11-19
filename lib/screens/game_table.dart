import 'package:flutter/material.dart';

class GameTable extends StatelessWidget {
  const GameTable({super.key, required difficultyLevel});

  @override
  Widget build(BuildContext context) {
    final difficultyLevel = ModalRoute.of(context)!.settings.arguments;
    String difficulty = difficultyLevel.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          Text(difficulty),
        ],
      ),
    );
  }
}
