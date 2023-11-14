import 'package:flutter/material.dart';

class GameTable extends StatelessWidget {
  const GameTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
