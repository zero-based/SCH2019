import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/rounded_button.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip"),
        leading: IconButton(
            icon: new Icon(
          Icons.close,
          color: Colors.white,
          size: 32,
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Timer here',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 60),
            RoundedButton(text: 'Open Google Maps', onPressed: _launchURL),
            SizedBox(height: 30),
            RoundedButton(
                text: 'Lower Parcade',
                onPressed: () {
                  print('Presses');
                }),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url =
        'https://www.google.com/maps/search/ADDRESS_OR_LATLNG_HERE/@30.0544315,31.2740701,15z';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
