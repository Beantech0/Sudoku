// ignore: file_names
import 'package:flutter/material.dart';

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

Widget inputTextFieldPass(String labeltext) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
  );
}