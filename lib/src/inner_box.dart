import 'package:sudoku/src/block_value.dart';

class InnerBox {
  late int index;
  List<BlockValue> blockValues = List<BlockValue>.from([]);

  InnerBox(this.index, this.blockValues);

  // declare method used
  setFocus(int index, Direction direction) {
    List<BlockValue> temp;

    if (direction == Direction.Horizontal) {
      temp = blockValues
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp = blockValues
          .where((element) => element.index! % 3 == index % 3)
          .toList();
    }

    for (var element in temp) {
      element.isFocus = true;
    }
  }

  setExistValue(
      int index, int indexBox, String textInput, Direction direction) {
    List<BlockValue> temp;

    if (direction == Direction.Horizontal) {
      temp = blockValues
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp = blockValues
          .where((element) => element.index! % 3 == index % 3)
          .toList();
    }

    if (this.index == indexBox) {
      List<BlockValue> blockValuesBox =
          blockValues.where((element) => element.text == textInput).toList();

      if (blockValuesBox.length == 1 && temp.isEmpty) blockValuesBox.clear();

      temp.addAll(blockValuesBox);
    }

    temp.where((element) => element.text == textInput).forEach((element) {
      element.isExist = true;
    });
  }

  clearFocus() {
    for (var element in blockValues) {
      element.isFocus = false;
    }
  }

  clearExist() {
    for (var element in blockValues) {
      element.isExist = false;
    }
  }
}

// ignore: constant_identifier_names
enum Direction { Horizontal, Vertical }
