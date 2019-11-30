import 'package:flutter/material.dart';

import '../models/user.dart';
import 'account_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parc'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(_user),
              ),
            ),
          ),
        ],
      ),
      body: MapScreen(),
    );
  }
}
