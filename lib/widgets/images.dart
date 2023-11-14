import 'package:flutter/material.dart';

Widget loginImage(String path) {
  return SizedBox(
    height: 250,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Image.asset(path),
    ),
  );
}