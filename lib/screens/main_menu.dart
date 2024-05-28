import 'package:flutter/material.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final String _loginImagePath = 'images/sudoku_logo_transparent.png';
  final bool? isLoggedIn = sharedPreferences.getBool('IS_LOGGED_IN');
  String? loggedUser = sharedPreferences.getString('loggedUser') ?? "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          child: ListView(
        children: [
          Center(
            child: Text(
                isLoggedIn == true ? 'Szia, $loggedUser' : '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
          ),
          loginImage(_loginImagePath),
          buttonPushNamed('New Game', context, '/GameDifficulty'),
          buttonPushNamed('Settings', context, '/Settings'),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  isLoggedIn == false
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content: Text('Nem vagy bejelentkezve!'),
                          backgroundColor: Colors.red,
                        ))
                      : Navigator.pushNamed(context, '/Scoreboard');
                },
                child: const Text('Scoreboard'),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  isLoggedIn == false
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content: Text('Nem vagy bejelentkezve nem tudsz kijelentkezni!'),
                          backgroundColor: Colors.red,
                        ))
                      : _logout();
                },
                child: const Text('Logout'),
              ),
            ),
          ),
          buttonQuit('Quit', context),
        ],
      )),
    );
  }

  _logout() {
    sharedPreferences.setBool('IS_LOGGED_IN', false);
    sharedPreferences.setString('loggedUser', "");
    Navigator.pushNamed(context, '/WelcomeScreen');
    setState(() {});
  }
}
