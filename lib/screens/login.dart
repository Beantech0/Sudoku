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
        title: Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        // decoration: BoxDecoration(color: Colors.grey[300]),
        child: Form(
            child: ListView(
          children: [
            loginImage(_loginImagePath),
            inputTextField('E-mail Address'),
            inputTextField('Password'),
            buttonPushNamed('Login', context, '/MainMenu'),
            buttonPushNamed('Registration', context, '/Settings'),
            buttonPushNamed('Login With Google', context, '/Scoreboard'),
          ],
        )),
      ),
    );
  }
}
