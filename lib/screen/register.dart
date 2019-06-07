import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Entrer votre information';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: RegisterForm(),
      ),
    );
  }
}

// Create a Form Widget
class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class RegisterFormState extends State<RegisterForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<RegisterFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    new Container();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          Center(
            child: new MaterialButton(
              height: 40.0,
              minWidth: 300.0,
              padding: const EdgeInsets.all(10.0),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                  //Scaffold.of(context)
                  //  .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Enregistrer'),
            ),
          ),
        ],
      ),
    );
  }
}
