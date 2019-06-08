import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gridview_app/constant/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class Register extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<Register> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _read());
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fiainana BDB'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Ampidiro ny anaranao'),
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        backgroundColor: Colors.red,
        onPressed: () {
          _save(myController.text);
          showDialog(
            context: context,
            builder: (context) {
              AlertDialog(
                content: Text('Bienvenue $myController.text'),
              );
            },
          );

          return Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
        },
        tooltip: 'Username!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}

_save(name) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'username';
  final value = name;
  prefs.setString(key, value);
  print('saved: $value');
}

_read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'username';
  final value = prefs.getString(key) ?? 0;
  print('read: $value');
}
