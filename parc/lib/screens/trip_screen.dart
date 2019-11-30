import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parc/blocs/reservation_bloc/bloc.dart';
import 'package:parc/blocs/timer_bloc/bloc.dart';
import 'package:parc/widgets/water_wave.dart';
import 'package:parc/models/reservation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/rounded_button.dart';

class TripScreen extends StatelessWidget {
  final Reservation reservation;

  TripScreen({this.reservation});

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
          ),
          onPressed: () {
            BlocProvider.of<ReservationBloc>(context).add(Cancel(reservation));
            BlocProvider.of<TimerBloc>(context).add(Reset());
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                final String minutesStr = ((state.duration / 60) % 60)
                    .floor()
                    .toString()
                    .padLeft(2, '0');
                final String secondsStr =
                    (state.duration % 60).floor().toString().padLeft(2, '0');
                return Container(
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Stack(children: [
                      Background(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              '$minutesStr:$secondsStr',
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                );
              },
            ),
            SizedBox(height: 60),
            RoundedButton(text: 'Open Google Maps', onPressed: _launchURL),
            SizedBox(height: 30),
            RoundedButton(
              text: 'Lower Parcade',
              onPressed: () => BlocProvider.of<ReservationBloc>(context).add(Arrive(reservation)),
            ),
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