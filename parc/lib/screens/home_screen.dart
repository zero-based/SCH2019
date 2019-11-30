import 'package:flutter/material.dart';

import '../models/user.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapScreen(),
    );
  }
}
