import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/services/location_service.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  final User _user;

  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<LatLng>(
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
        title: "Home",
        home: Scaffold(
          body: MapWidget(),
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> markers = Set<Marker>()
    ..add(Marker(
      markerId: MarkerId('Berlin'),
      position: LatLng(52.5200, 13.4050),
    ));

  @override
  Widget build(BuildContext context) {
    var currentLocation = Provider.of<LatLng>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Search ...',
            ),
            controller: _searchController,
          ),
          Expanded(
            flex: 1,
            child: GoogleMap(
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation.latitude,
                  currentLocation.longitude,
                ),
                zoom: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
