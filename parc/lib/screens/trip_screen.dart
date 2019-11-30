import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parc/blocs/timer_bloc/bloc.dart';
import 'package:parc/models/ticker.dart';
import 'package:parc/widgets/water_wave.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/rounded_button.dart';

class TripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TimerBloc>(
        create: (context) => TimerBloc(Ticker()),
        child: _TripScreen(),
      ),
    );
  }
}

class _TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<_TripScreen> {
  @override
  Widget build(BuildContext context) {
    final TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip"),
        leading: IconButton(
          icon: new Icon(
            Icons.close,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => _timerBloc.add(Reset()),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BlocBuilder(
              bloc: _timerBloc,
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
              onPressed: () => _timerBloc.add(Start(duration: 15 * 60)),
            ),
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