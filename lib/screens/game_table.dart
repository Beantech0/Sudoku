// Sudoku tábla screen
// StatefulWidget, minden változtatásnál újra buildeli a screent
// Számok generálása a táblához => generateSudoku()

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:sudoku/db/db_helper.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/src/block_value.dart';
import 'package:sudoku/src/focus.dart';
import 'package:sudoku/src/inner_box.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class GameTable extends StatefulWidget {
  const GameTable({super.key, required difficultyLevel, required difficulty});
  @override
  State<GameTable> createState() => _GameTable();
}

class _GameTable extends State<GameTable> {
  // late final int difficultyLevel =ModalRoute.of(context)!.settings.arguments['difficultyLevel'] as int;
  
  List<InnerBox> innerBoxes = [];
  FocusClass focusClass = FocusClass();
  bool isFinish = false;
  String? tapBoxIndex;

    Future _saveHistory(loggedUserID, startTime, difficulty, isFinished) async {  
        print(difficulty);
        int id = await DatabaseHelper.instance
        // .createHistory(userid: int.parse(loggedUserID), startTime: startTime, difficulty: difficulty);
        .createHistory(userid: int.parse(loggedUserID), startTime: startTime, difficulty: difficulty, isFinished: isFinished );
         sharedPreferences.setInt('lastHistoryID', id);
    }

  // Az oldal létrejötténél fut le.
  @override
  void initState() {
    super.initState();
  }

  //Az initState után fut le amikor már megkapjuk a context értékét és tudjuk hogy milyen a nehézségi fokozat.
  @override
  void didChangeDependencies() {
    String? loggedUserID = sharedPreferences.getString('loggedUserID') ?? "";
    DateTime currentDateTime = DateTime.now();
    String currentTime = currentDateTime.toString();

    late final arguments = (ModalRoute.of(context)!.settings.arguments ?? <String, dynamic>{}) as Map;
    late final int difficultyLevel = arguments['emptyBlockNumber'];
    late final String difficulty = arguments['difficulty'].toString();

    if (loggedUserID != "") {
      _saveHistory(loggedUserID, currentTime, difficulty, 0);
    }
    generateSudoku(difficultyLevel);
    super.didChangeDependencies();
  }

  void generateSudoku(difficultyLevel) {
    isFinish = false;
    focusClass = FocusClass();
    tapBoxIndex = null;
    generatePuzzle(difficultyLevel);
    checkFinish();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              //Sudoku táblázat kirajzolás
              //GridView builder csinál egy "kockát" amit aztán az ItemBuilder "legyárt" amennyi az itemCount, kb mint egy for ciklus
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(2),
                color: Colors.teal,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: innerBoxes.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  physics: const ScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    InnerBox innerBox = innerBoxes[index];
                    return Container(
                      color: Colors.blue.shade100,
                      alignment: Alignment.center,

                      // Minden "kockán" belül lefut még 9x és az adott widgeten belül csinál 9 widgetet ugyanolyan elrendezésben
                      child: GridView.builder(
                        itemCount: innerBox.blockValues.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        physics: const ScrollPhysics(),
                        itemBuilder: (buildContext, indexChar) {
                          BlockValue blockValue =
                              innerBox.blockValues[indexChar];
                          Color color = Colors.yellow.shade100;
                          Color colorText = Colors.black;

                          // change color base condition

                          if (isFinish) {
                            color = Colors.green;
                          } else if (blockValue.isFocus &&
                              blockValue.text != "") {
                            color = Colors.brown.shade100;
                          } else if (blockValue.isDefault) {
                            color = Colors.grey.shade400;
                          }

                          if (tapBoxIndex == "$index-$indexChar" && !isFinish) {
                            color = Colors.blue.shade100;
                          }

                          if (isFinish) {
                            colorText = Colors.white;
                          } else if (blockValue.isExist) {
                            colorText = Colors.red;
                          }
                          return Container(
                            color: color,
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: blockValue.isDefault
                                  ? null
                                  : () => setFocus(index, indexChar),
                              child: Text(
                                "${blockValue.text}",
                                style: TextStyle(color: colorText),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              //Kezelőfelület kirakás 9 gomb 1-től 9-ig + 1 törlés
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: GridView.builder(
                          itemCount: 9,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          physics: const ScrollPhysics(),
                          itemBuilder: (buildContext, index) {
                            return ElevatedButton(
                              onPressed: () => setInput(index + 1),
                              child: Text("${index + 1}"),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () => setInput(null),
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 250)),
                            child: const Text('Törlés'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  generatePuzzle(difficultyLevel) {
    // install plugins sudoku generator to generate one
    innerBoxes.clear();
    var sudokuGenerator = SudokuGenerator(emptySquares: difficultyLevel, uniqueSolution: true); //54
    // then we populate to get a possible cmbination
    // Quiver for easy populate collection using partition
    List<List<List<int>>> completes = partition(sudokuGenerator.newSudokuSolved,
            sqrt(sudokuGenerator.newSudoku.length).toInt())
        .toList();
    partition(sudokuGenerator.newSudoku,
            sqrt(sudokuGenerator.newSudoku.length).toInt())
        .toList()
        .asMap()
        .entries
        .forEach(
      (entry) {
        List<int> tempListCompletes =
            completes[entry.key].expand((element) => element).toList();
        List<int> tempList = entry.value.expand((element) => element).toList();

        tempList.asMap().entries.forEach((entryIn) {
          int index =
              entry.key * sqrt(sudokuGenerator.newSudoku.length).toInt() +
                  (entryIn.key % 9).toInt() ~/ 3;

          if (innerBoxes.where((element) => element.index == index).isEmpty) {
            innerBoxes.add(InnerBox(index, []));
          }

          InnerBox innerBox =
              innerBoxes.where((element) => element.index == index).first;

          innerBox.blockValues.add(BlockValue(
            entryIn.value == 0 ? "" : entryIn.value.toString(),
            index: innerBox.blockValues.length,
            isDefault: entryIn.value != 0,
            isCorrect: entryIn.value != 0,
            correctText: tempListCompletes[entryIn.key].toString(),
          ));
        });
      },
    );

    // complte generate puzzle sudoku
  }

  setFocus(int index, int indexChar) {
    tapBoxIndex = "$index-$indexChar";
    focusClass.setData(index, indexChar);
    showFocusCenterLine();
    setState(() {});
  }

  void showFocusCenterLine() {
    // set focus color for line vertical & horizontal
    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    for (var element in innerBoxes) {
      element.clearFocus();
    }

    innerBoxes.where((element) => element.index ~/ 3 == rowNoBox).forEach(
        (e) => e.setFocus(focusClass.indexChar!, Direction.Horizontal));

    innerBoxes
        .where((element) => element.index % 3 == colNoBox)
        .forEach((e) => e.setFocus(focusClass.indexChar!, Direction.Vertical));
  }

  setInput(int? number) {
    // set input data based grid
    // or clear out data
    if (focusClass.indexBox == null) return;
    if (innerBoxes[focusClass.indexBox!]
                .blockValues[focusClass.indexChar!]
                .text ==
            number.toString() ||
        number == null) {
      for (var element in innerBoxes) {
        element.clearFocus();
        element.clearExist();
      }
      innerBoxes[focusClass.indexBox!]
          .blockValues[focusClass.indexChar!]
          .setEmpty();
      tapBoxIndex = null;
      isFinish = false;
      showSameInputOnSameLine();
    } else {
      innerBoxes[focusClass.indexBox!]
          .blockValues[focusClass.indexChar!]
          .setText("$number");

      showSameInputOnSameLine();

      checkFinish();
    }

    setState(() {});
  }

  void showSameInputOnSameLine() {
    // show duplicate number on same line vertical & horizontal so player know he or she put a wrong value on somewhere

    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    String textInput = innerBoxes[focusClass.indexBox!]
        .blockValues[focusClass.indexChar!]
        .text!;

    for (var element in innerBoxes) {
      element.clearExist();
    }

    innerBoxes.where((element) => element.index ~/ 3 == rowNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.Horizontal));

    innerBoxes.where((element) => element.index % 3 == colNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.Vertical));

    List<BlockValue> exists = innerBoxes
        .map((element) => element.blockValues)
        .expand((element) => element)
        .where((element) => element.isExist)
        .toList();

    if (exists.length == 1) exists[0].isExist = false;
  }

  void checkFinish() {
    int totalUnfinish = innerBoxes
        .map((e) => e.blockValues)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;

    isFinish = totalUnfinish == 0;
  }
}
