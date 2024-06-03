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

Future<List<Map<String, dynamic>>> _getHistory() async {
  String loggedUserID = sharedPreferences.getString('loggedUserID') ?? "";
  final history =
      await DatabaseHelper.instance.getHistory(userid: int.parse(loggedUserID));
  return history;
}

class _ScoreboardState extends State<Scoreboard> {
  String? loggedUser = sharedPreferences.getString('loggedUser') ?? "";
  Future<List<Map<String, dynamic>>> history = _getHistory();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final loadedHistory = await _getHistory();
    setState(() {
      history = loadedHistory as Future<List<Map<String, dynamic>>>;
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getHistory(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Hiba történt: ${snapshot.error}');
                      } else {
                        final history = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Play Count: ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('${history.length}'),
                            Text(
                              'Hard: ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Medium: ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Easy: ',
                              style: TextStyle(fontSize: 20),
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
