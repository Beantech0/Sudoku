import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;


class Settings extends StatefulWidget {
  const Settings({super.key});
  
  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool darkMode = false;
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
            value: darkMode,
            onChanged: (bool value) {
              setState(() {
                // _darkMode = value;
                prefs.setBool('darkMode', value);
              });
            },
            secondary: const Icon(Icons.color_lens_outlined),
          )
        ],
      ),
    );
  }
}
