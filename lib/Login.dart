import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Login extends StatefulWidget {
  static final String route = 'Login-route';

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final db = FirebaseDatabase.instance;
  final myController = TextEditingController();
  final name = 'Name';

  @override
  Widget build(BuildContext context) {
    final ref = db.reference();
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: null,
    );
  }
}
