import 'package:flutter/material.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';
import 'package:sudoku/widgets/inputFields.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});
  final String _loginImagePath = 'images/sudoku_logo_transparent.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          child: ListView(
        children: [
          loginImage(_loginImagePath),
          inputTextField('E-mail Address'),
          inputTextFieldPass('Password'),
          inputTextFieldPass('Password again'),
          buttonPushNamed('Regisztrálás', context, '/MainMenu'),
        ],
      )),
    );
  }
}
