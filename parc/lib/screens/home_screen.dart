import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parc/blocs/reservation_bloc/bloc.dart';
import 'package:parc/screens/parking_screen.dart';
import 'package:parc/screens/trip_screen.dart';
import 'package:parc/util/theme.dart';

import '../models/user.dart';
import 'account_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        if (state is Free) {
          return Scaffold(
            appBar: GradientAppBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logo_white.png',
                  fit: BoxFit.contain,
                ),
              ),
              centerTitle: true,
              backgroundColorStart:
                  appThemeData[AppTheme.Gredient].primaryColor,
              backgroundColorEnd:
                  appThemeData[AppTheme.Gredient].primaryColorDark,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => _navigateToAccountScreen(context),
                ),
              ],
            ),
            body: MapScreen(_user),
          );
        } else if (state is Reserved) {
          return TripScreen(reservation: state.reservation);
        } else if (state is Parked) {
          return ParkingScreen(reservation: state.reservation);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _navigateToAccountScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountScreen(_user),
      ),
    );
  }
}
