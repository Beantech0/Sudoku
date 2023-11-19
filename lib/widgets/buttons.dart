import 'dart:io';
import 'package:flutter/material.dart';

Widget buttonPushNamed(String buttonText, context, String navigateTo) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
      ),
      onPressed: () {
        Navigator.pushNamed(context, navigateTo, arguments: buttonText);
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

Widget buttonQuit(String buttonText, context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
      ),
      onPressed: () {
        exit(0);
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
