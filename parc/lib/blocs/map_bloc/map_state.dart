import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/models/parcade.dart';

class MapState extends Equatable {
  final bool isLoading;
  final LatLng latLng;
  final Set<Marker> markers;
  final bool openModal;
  final Parcade tappedParcade;

  MapState({
    this.isLoading,
    this.latLng,
    this.markers,
    this.openModal,
    this.tappedParcade,
  });

  @override
  List<Object> get props =>
      [isLoading, latLng, markers, openModal, tappedParcade];

  MapState update({
    bool isLoading: false,
    LatLng latLng,
    Set<Marker> markers,
    bool openModal: false,
    Parcade tappedParcade,
  }) {
    return copyWith(
      isLoading: isLoading,
      latLng: latLng,
      markers: markers,
      openModal: openModal,
      tappedParcade: tappedParcade,
    );
  }

  MapState copyWith({
    bool isLoading,
    LatLng latLng,
    Set<Marker> markers,
    bool openModal,
    Parcade tappedParcade,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      latLng: latLng ?? this.latLng,
      markers: markers ?? this.markers,
      openModal: openModal ?? this.openModal,
      tappedParcade: tappedParcade ?? this.tappedParcade,
    );
  }

  @override
  String toString() {
    return '''MapState {
      isLoading: $isLoading,
      latLng: $latLng,
      markers: $markers,
      openModal: $openModal,
      tappedParcade: $tappedParcade
    }''';
  }
}
