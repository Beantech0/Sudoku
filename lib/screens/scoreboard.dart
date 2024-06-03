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

  Future _getHistory() async {
  String loggedUserID = sharedPreferences.getString('loggedUserID') ?? "";
  final history = await DatabaseHelper.instance
        .getHistory(userid: int.parse(loggedUserID));
  print(history);
  return history;
  }

class _ScoreboardState extends State<Scoreboard> {
  String? loggedUser = sharedPreferences.getString('loggedUser') ?? "";
  final history = _getHistory();
  
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Play Count: ',style: TextStyle(fontSize: 20),),
                  Text('Hard: ',style: TextStyle(fontSize: 20),),
                  Text('Medium: ',style: TextStyle(fontSize: 20),),
                  Text('Easy: ',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Fastest game:  min',style: TextStyle(fontSize: 20),),
            ),
          ],
                    ),),
        ),
      ),
    );
  }
}
