import 'package:flutter/material.dart';
import 'package:sudoku/db/db_helper.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/screens/main_menu.dart';
import 'package:sudoku/screens/registration.dart';
import 'package:sudoku/screens/welcome_screen.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';
import 'package:sudoku/widgets/inputFields.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String _loginImagePath = 'images/sudoku_logo_transparent.png';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await DatabaseHelper.instance
        .loginUser(username: username, password: password);

    if (!context.mounted) return;

    // provide feedback to the user on whether the query succeeded or failed
    if (user.isNotEmpty) {
      //store login state
      sharedPreferences.setBool('IS_LOGGED_IN', true);
      sharedPreferences.setString('loggedUser', username);
      final String userID = user[0]['id'].toString();
      sharedPreferences.setString('loggedUserID', userID);
      // User found, login successful
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sikeres belépés!'),
        backgroundColor: Colors.green,
      ));

      // This code will replace the current route with the new HomeScreen
      // and remove all routes on top of it from the navigation stack.
      // This will prevent the user from clicking back button
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainMenu()),
          (route) => false);
    } else {
      // User not found or incorrect password
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Hibás felhasználónév vagy jelszó!'),
        backgroundColor: Colors.red,
      ));
    }
  }
  
  @override
  void dispose() {
    // dispose of the controllers before the widget is disposed
    // to prevent memory leaks
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          child: ListView(
        children: [
          loginImage(_loginImagePath),
          // inputTextField('E-mail Address'),
           Padding(
             padding: const EdgeInsets.all(10),
             child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: const Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
           ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                  ),
          ),
                // Login button
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: TextButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      //
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Registration()));
                    },
                    child: const Text('Create Account'),
                  ),),
        ],
      )),
    );
  }
}
