import 'package:flutter/material.dart';

class GameTable extends StatefulWidget {
  const GameTable({super.key, required difficultyLevel});

  @override
  State<GameTable> createState() => _GameTable();
}

class _GameTable extends State<GameTable> {
  @override
  Widget build(BuildContext context) {
    final difficultyLevel = ModalRoute.of(context)!.settings.arguments;
    String difficulty = difficultyLevel.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('asd'),
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
                  itemCount: 9,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  physics: const ScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    return Container(
                      color: Colors.blue.shade100,
                      alignment: Alignment.center,

                      // Minden "kockán" belül lefut még 9x és az adott widgeten belül csinál 9 widgetet ugyanolyan elrendezésben
                      child: GridView.builder(
                        itemCount: 9,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        physics: const ScrollPhysics(),
                        itemBuilder: (buildContext, index) {
                          return Container(
                            margin: const EdgeInsets.all(3),
                            color: Colors.yellow.shade100,
                            alignment: Alignment.center,
                            child: Text("${index + 1}"),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(2),
                  color: Colors.teal,
                  width: double.maxFinite,
                  alignment: Alignment.center,
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
                      return Container(
                        margin: const EdgeInsets.all(3),
                        color: Colors.yellow.shade100,
                        alignment: Alignment.center,
                        child: Text("${index + 1}"),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: InkWell(
                  child: Text('Tes'),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
