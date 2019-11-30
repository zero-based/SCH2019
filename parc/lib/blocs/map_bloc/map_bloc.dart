import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/models/parcade.dart';

import './bloc.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  @override
  MapState get initialState => MapState(isLoading: true);

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is LoadCurrent) {
      yield* _mapLoadCurrentToState();
    } else if (event is TapMarker) {
      yield* _mapTapMarkerToState(event.parcade);
    } else if (event is UnTapMarker) {
      yield* _mapUnTapMarkerToState();
    }
  }

  Stream<MapState> _mapLoadCurrentToState() async* {
    var location = await Geolocator().getCurrentPosition();
    var latLng = LatLng(location.latitude, location.longitude);

    // TODO: REMOVE THIS PARCADE
    var dummyParcade = Parcade(
        id: "yWd1zMCbr0SQqKEUnX9u",
        latLng: LatLng(30.04685, 31.24033),
        isAvailable: true,
        area: "wust el balad",
        address: "16 El Bostan St., Cairo");

    // TODO: REMOVE THIS MARKER
    var dummyMarker = Marker(
        markerId: MarkerId("yWd1zMCbr0SQqKEUnX9u"),
        position: dummyParcade.latLng,
        onTap: () => add(TapMarker(dummyParcade)));

    // TODO: REMOVE THIS PARCADE
    var dummyParcade2 = Parcade(
        id: "sA3vub5Fuq8pzZuGJn0w",
        latLng: LatLng(30.09156, 31.32195),
        isAvailable: true,
        area: "heliopolis",
        address: "31 El Korba St., Cairo");

    // TODO: REMOVE THIS MARKER
    var dummyMarker2 = Marker(
        markerId: MarkerId("sA3vub5Fuq8pzZuGJn0w"),
        position: dummyParcade2.latLng,
        onTap: () => add(TapMarker(dummyParcade2)));

    yield state.update(
      latLng: latLng,
      markers: Set<Marker>()..add(dummyMarker)..add(dummyMarker2),
      
    );
  }

  Stream<MapState> _mapTapMarkerToState(Parcade parcade) async* {
    yield state.update(openModal: true, tappedParcade: parcade);
  }

  Stream<MapState> _mapUnTapMarkerToState() async* {
    yield state.update(tappedParcade: null);
  }
}
