import 'package:flutter/material.dart';

import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Text("Welcome ${widget._user.name} to Parc!"),
      ),
    );
  }
}
