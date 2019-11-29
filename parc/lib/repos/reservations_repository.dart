import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/models/parcade.dart';
import 'package:parc/models/reservation.dart';

class ReservationRepository {
  static final Firestore _db = Firestore.instance;

  static void make(Parcade parcade, String userId) {
    WriteBatch batch = Firestore.instance.batch();

    var reservationsRef = _db.collection('reservations').document();
    var reservation = Reservation(
        id: reservationsRef.documentID,
        userId: userId,
        parcadeId: parcade.id,
        arrived: false,
        reservationTimestamp: Timestamp.now());
    batch.setData(reservationsRef, reservation.toMap());

    var userRef = _db.collection('users').document(userId);
    batch.updateData(userRef, {"currentReservation": reservation.id});

    var parcadeRef = _db.collection('parcades').document(parcade.id);
    batch.updateData(parcadeRef, {"isAvailable": false});

    batch.commit();
  }

  static void updateState(Parcade parcade, String userId) async {
    var user = await _db.collection('users').document(userId).get();
    _db
        .collection('reservations')
        .document(user["currentReservation"])
        .updateData({"arrivalTimestamp": Timestamp.now()});
  }

  static void cancel(Parcade parcade, String userId) async {
    WriteBatch batch = Firestore.instance.batch();
    var user = await _db.collection('users').document(userId).get();
    var resRef =
        _db.collection('reservations').document(user["currentReservation"]);
    batch.updateData(resRef, {"cancelationTimestamp": Timestamp.now()});

    var parcadeRef = _db.collection('parcades').document(parcade.id);
    batch.updateData(parcadeRef, {"isAvailable": true});
    batch.commit();
  }
}
