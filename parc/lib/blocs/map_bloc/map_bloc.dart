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
        id: "sA3vub5Fuq8pzZuGJn0w",
        latLng: latLng,
        isAvailable: true,
        area: "Cairo",
        address: "91 Nameless St. Cario");

    // TODO: REMOVE THIS MARKER
    var dummyMarker = Marker(
        markerId: MarkerId("dummy"),
        position: latLng,
        onTap: () => add(TapMarker(dummyParcade)));

    yield state.update(
      latLng: latLng,
      markers: Set<Marker>()..add(dummyMarker),
    );
  }

  Stream<MapState> _mapTapMarkerToState(Parcade parcade) async* {
    yield state.update(openModal: true, tappedParcade: parcade);
  }

  Stream<MapState> _mapUnTapMarkerToState() async* {
    yield state.update(tappedParcade: null);
  }
}
