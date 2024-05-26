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
  return SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {Navigator.pushNamed(context, navigateTo, arguments: emptyBlockNumber);
                      },
                      child: Text(buttonText),
                    ),
                  ),
                );
}

Widget buttonQuit(String buttonText, context) {
  return SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(buttonText),
                    ),
                  ),
                );
}
