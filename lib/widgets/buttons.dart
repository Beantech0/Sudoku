import 'dart:io';
import 'package:flutter/material.dart';
    Map difficultyList = {
      5:  'Test',
      18: 'Easy',
      27: 'Medium',
      36: 'Hard',
    };

Widget buttonPushNamed(String buttonText, context, String navigateTo) {
  var emptyBlockNumber = difficultyList.keys.firstWhere((element) => difficultyList[element] == buttonText, orElse: () => 2);
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
      ),
      onPressed: () {
        Navigator.pushNamed(context, navigateTo, arguments: emptyBlockNumber);
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
