import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/models/parcade.dart';
import 'package:parc/services/location_service.dart';
import 'package:parc/widgets/parcade_modal.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'account_screen.dart';

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
          appBar: AppBar(
            title: const Text('Parc'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(_user),
                  ),
                ),
              ),
            ],
          ),
          body: MapWidget(),
        ),
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    // Hardcoded Data
    var location = Provider.of<LatLng>(context);
    var currentLatLng = LatLng(location.latitude, location.longitude);
    markers.add(Marker(
      markerId: MarkerId('Here'),
      position: currentLatLng,
      onTap: () => _showModal(currentLatLng),
    ));

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
                target: currentLatLng,
                zoom: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModal(LatLng latLng) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ParcadeModal(
        Parcade(
          id: "SCH",
          area: "Wust El Balad",
          address: "16 Wsdfrf St., Cario Egypt",
          isAvailable: true,
          latLng: latLng,
        ),
      ),
    );
  }
}
