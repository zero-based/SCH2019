import 'package:flutter/material.dart';

enum AppTheme { Gredient }

final appThemeData = {
  AppTheme.Gredient: ThemeData(
      backgroundColor: Colors.white,
      splashColor: Color(0XFF356CA7),
      errorColor: Color(0XFFDC3545),
      primaryColor: Color(0XFF8C5191),
      primaryColorDark: Color(0XFF43316F),
      primaryColorLight: Color(0XFF5788CE),
      accentColor: Color(0XFF3176B1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[900],
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      bottomAppBarColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0XFF43316F)),
      fontFamily: 'Almarai'),
};
