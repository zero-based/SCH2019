import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/models/userLocation.dart';
import 'package:parc/services/locationService.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
          home: Scaffold(
        body: MapWidget(),
      )),
    );
  }
}

class MapWidget extends StatelessWidget {
  static final MarkerId markerId = MarkerId('Berlin');
  final Marker marker = Marker(position: LatLng(52.5200, 13.4050), markerId: markerId);
  final Set<Marker> markers = new Set<Marker>();
  final TextEditingController _searchLocationController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var x = Provider.of<UserLocation>(context);
    markers.add(marker);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search ...',
                ),
                controller: _searchLocationController,
              ),
              Expanded(
                flex: 1,
                child: GoogleMap(
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(x.latitude, x.longitude), zoom: 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
