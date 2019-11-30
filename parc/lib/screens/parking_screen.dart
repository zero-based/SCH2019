import 'package:flutter/material.dart';
import 'package:parc/models/reservation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/rounded_button.dart';

class ParkingScreen extends StatelessWidget {
  final Reservation reservation;

  ParkingScreen({this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parking")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Your vehicle is resting somewhere safe!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 60),
            RoundedButton(text: 'See where?', onPressed: _launchURL),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    var lat = reservation.parcade.latLng.latitude;
    var lng = reservation.parcade.latLng.longitude;
    var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
