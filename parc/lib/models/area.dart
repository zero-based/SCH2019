import 'package:cloud_firestore/cloud_firestore.dart';

class Area {
  String id;
  String name;
  double longitude;
  double latitude;

  Area(this.id, this.name, this.longitude, this.latitude);

  factory Area.fromDocument(DocumentSnapshot doc) {
    return Area(
      doc['id'],
        doc['name'],
        doc['longitude'],
        doc['latitude']);
  }

  Map<String, dynamic> toMap() {
    return {'id':id, 'name': name, 'longitude': longitude, 'latitude': latitude};
  }

  @override
  String toString() {
    return '''Area{
      id: $id,
      name: $name,
      longitude: $longitude,
      latitude: $latitude
    }''';
  }
}