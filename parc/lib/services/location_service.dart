import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  var location = Location();

  StreamController<LatLng> _controller = StreamController<LatLng>();

  Stream<LatLng> get locationStream => _controller.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((data) {
          if (data != null) {
            _controller.add(LatLng(data.latitude, data.longitude));
          }
        });
      }
    });
  }
}
