import 'package:flutter/material.dart';

Widget button(String buttonText, context, String navigateTo) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
      ),
      onPressed: () {
        Navigator.pushNamed(context, navigateTo);
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}
