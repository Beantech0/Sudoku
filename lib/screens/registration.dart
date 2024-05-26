import 'package:flutter/material.dart';
import 'package:sudoku/db/db_helper.dart';
import 'package:sudoku/screens/login.dart';
import 'package:sudoku/widgets/buttons.dart';
import 'package:sudoku/widgets/images.dart';
import 'package:sudoku/widgets/inputFields.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final String _loginImagePath = 'images/sudoku_logo_transparent.png';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController = TextEditingController();

  Future<void> _register() async {
    // store the values of controllers into variables for easy reference
    final username = _usernameController.text;
    final password = _passwordController.text;
    final passwordAgain = _passwordAgainController.text;

    if (password != passwordAgain)  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('A két jelszó nem egyezik meg!'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    int userIsExists = await DatabaseHelper.instance.checkUser(username: username);
    // result returns the ID of the latest inserted record
    int result = await DatabaseHelper.instance
        .createUser(username: username, password: password);

    if (!context.mounted) return;

    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sikeres regisztráció'),
        backgroundColor: Colors.green,
      ));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    } else {
      //
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to register user!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          child: ListView(
        children: [
          loginImage(_loginImagePath),
          // Username
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'User Name',
              prefixIcon: const Icon(Icons.alternate_email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          // Password
          TextFormField(
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
          const SizedBox(
            height: 24,
          ),
          // Password
          TextFormField(
            controller: _passwordAgainController,
            decoration: InputDecoration(
              hintText: 'Password Again',
              prefixIcon: const Icon(Icons.key),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 48,
          ),
          // Register
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
                onPressed: _register,
                child: const Text('Registration'),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
