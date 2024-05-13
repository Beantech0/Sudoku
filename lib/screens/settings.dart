import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  
  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  late SharedPreferences prefs;
  bool isDarkMode = false;
  bool showWrongNumbersInRed = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? true;
    });
  }

  void _toggleDarkMode(bool newValue) {
    setState(() {
      isDarkMode = newValue;
      prefs.setBool('darkMode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        // backgroundColor: Colors.teal,
      ),
      body: Wrap(
        alignment: WrapAlignment.center,
        children: [
          const Card(
            child: ListTile(
              title: Text('Themes'),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: isDarkMode,
            onChanged: _toggleDarkMode,
            secondary: const Icon(Icons.color_lens_outlined),
          ),
                    const Card(
            child: ListTile(
              title: Text('Game Settings'),
            ),
          ),
          SwitchListTile(
            title: const Text('Show wrong numbers in red colos'),
            value: showWrongNumbersInRed,
            onChanged: null,
            secondary: const Icon(Icons.color_lens_outlined),
          )
        ],
      ),
    );
  }
}
