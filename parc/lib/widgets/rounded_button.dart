import 'package:flutter/material.dart';
import 'package:parc/util/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;

  RoundedButton({
    this.text,
    this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      splashColor: appThemeData[AppTheme.Gredient].splashColor,
      minWidth: 180.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: <Color>[
              appThemeData[AppTheme.Gredient].primaryColor,
              appThemeData[AppTheme.Gredient].primaryColorDark,
            ],
          ),
        ),
        child: RaisedButton(
          color: outlined ? Colors.white : Colors.transparent,
          textColor: Colors.white,
          textTheme: ButtonTextTheme.accent,
          elevation: 0,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            side: outlined
                ? BorderSide(
                    color: appThemeData[AppTheme.Gredient].primaryColorDark,
                    width: 2.5,
                    style: BorderStyle.solid,
                  )
                : BorderSide.none,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Almarai',
                  color: outlined
                      ? appThemeData[AppTheme.Gredient].textTheme.button.color
                      : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
