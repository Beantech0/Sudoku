import 'package:flutter/material.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';
import 'package:sudoku/widgets/inputFields.dart';



class Login extends StatelessWidget {
  const Login({super.key});
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
          inputTextField('E-mail Address'),
          inputTextFieldPass('Password'),
          buttonPushNamed('Login', context, '/MainMenu'),
          buttonPushNamed('Registration', context, '/Registration'),
        ],
      )),
    );
  }
}
