import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sudoku/db/db_helper.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

  Future<Map<String, int>> _getHistory() async {
  String loggedUserID = sharedPreferences.getString('loggedUserID') ?? "";
  final Map<String, int> historyList = {
        'Test': 0,
        'Easy': 0,
        'Medium': 0,
        'Hard': 0,
      };
  final history =
      await DatabaseHelper.instance.getHistory(userid: int.parse(loggedUserID));

      for (var element in history) {
        historyList.update(element['difficulty'].toString(), (value) => int.parse(element['count'].toString()));
      }
  return historyList;
}

class _ScoreboardState extends State<Scoreboard> {
  String? loggedUser = sharedPreferences.getString('loggedUser') ?? "";
  final history = _getHistory();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final loadedHistory = await _getHistory();
    setState(() {
      final history = loadedHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Szia, $loggedUser',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FutureBuilder<Map<String, int>>(
                    future: _getHistory(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, int>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Hiba történt: ${snapshot.error}');
                      } else {
                        final history = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                             Text(
                              'Total Played Count: ${history['Test']! + history['Easy']! + history['Medium']! + history['Hard']!}',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Test: ${history['Test']}',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Easy: ${history['Easy']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Medium: ${history['Medium']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Hard: ${history['Hard']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Fastest game:  min',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
