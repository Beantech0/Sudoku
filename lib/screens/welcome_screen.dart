import 'package:flutter/material.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // _initDatabase();
  }

  final String _loginImagePath = 'images/sudoku_logo_transparent.png';
  String? loggedUser = sharedPreferences.getString('loggedUser') ?? "";
  final bool? isLoggedIn = sharedPreferences.getBool('IS_LOGGED_IN');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          child: ListView(
        children: [
          Text(loggedUser!),
          loginImage(_loginImagePath),
          isLoggedIn != true
              ? buttonPushNamed('Login', context, '/Login')
              : SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        _logout();
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ),
          buttonPushNamed('Play without Login', context, '/MainMenu'),
          buttonQuit('Quit', context),
        ],
      )),
    );
  }

  _logout() {
    sharedPreferences.setBool('IS_LOGGED_IN', false);
    sharedPreferences.setString('loggedUser', "");
    setState(() {});
  }
}
