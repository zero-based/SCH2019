import 'package:flutter/material.dart';
import 'modal_tile.dart';
import '../models/user.dart';

class ModalSheet extends StatelessWidget {
  ModalSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ModalTile(
              text: 'switch_language',
              icon: Icons.language,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ModalTile(
              text: 'help',
              icon: Icons.help_outline,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ModalTile(text: 'feedback', icon: Icons.feedback, onTap: () {})
          ],
        ),
      ),
    );
  }
}
