import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/models/area.dart';

class AreaRepository {
  static final Firestore _db = Firestore.instance;

  static Stream<List<Area>> getAreas() {
    return _db.collection('areas').
    snapshots().
    map((snapshot) {
      return snapshot
          .documents
          .map((doc) =>
          Area.fromDocument(doc)).toList();
    });
  }
}
