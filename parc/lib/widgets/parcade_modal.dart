import 'package:flutter/material.dart';
import 'package:parc/models/parcade.dart';
import 'package:parc/widgets/rounded_button.dart';

class ParcadeModal extends StatelessWidget {
  final Parcade parcade;

  ParcadeModal(this.parcade);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              parcade.area.toUpperCase(),
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              parcade.address,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            RoundedButton(
              text: "Reserve",
            )
          ],
        ),
      ),
    );
  }
}
