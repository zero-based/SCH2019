import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Parcade {
  final String id;
  final String area;
  final String address;
  final LatLng latLng;
  final bool isAvailable;

  Parcade({
    this.id,
    this.area,
    this.address,
    this.latLng,
    this.isAvailable,
  });

  factory Parcade.fromDocument(DocumentSnapshot doc) {
    return Parcade(
      id: doc['id'],
      area: doc['area'],
      address: doc['address'],
      latLng: LatLng(
        doc['latitude'].toDouble(),
        doc['longitude'].toDouble(),
      ),
      isAvailable: doc['isAvailable'],
    );
  }
}
