import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  final String _loginImagePath = 'images/calculator-icon.png';

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
          inputTextField('Login'),
          button('Login'),
          button('Play without Login')
        ],
      )),
    );
  }
}

Widget loginImage(String path) {
  return SizedBox(
    height: 250,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Image.asset(path),
    ),
  );
}

Widget inputTextField(String labeltext) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
  );
}

Widget button(String buttonText) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
        ),
        onPressed: () {},
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
