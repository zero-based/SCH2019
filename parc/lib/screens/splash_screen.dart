import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:parc/util/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeData[AppTheme.Gredient].backgroundColor,
      body: Center(
        child: Container(
            height: 256,
            alignment: Alignment.center,
            child: FlareActor("assets/parcupdown.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "updown")),
      ),
    );
  }
}
