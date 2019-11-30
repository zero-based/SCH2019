import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/models/parcade.dart';
import 'package:parc/models/reservation.dart';

class ReservationRepository {
  static final Firestore _db = Firestore.instance;

  static Future<Reservation> get(String reservationId) async {
    var reservationDoc =
        await _db.collection("reservations").document(reservationId).get();
    var reservation = Reservation.fromDocument(reservationDoc);
    var parcadeDoc =
        await _db.collection("parcades").document(reservation.parcade.id).get();
    reservation.parcade = Parcade.fromDocument(parcadeDoc);
    return reservation;
  }

  static Future<void> make(Reservation reservation) {
    WriteBatch batch = _db.batch();

    var reservationDoc = _db.collection("reservations").document();
    reservation.id = reservationDoc.documentID;
    batch.setData(reservationDoc, reservation.toMap());

    var userDoc = _db.collection("users").document(reservation.userId);
    batch.updateData(userDoc, {"currentReservation": reservation.id});

    var parcadeDoc =
        _db.collection('parcades').document(reservation.parcade.id);
    batch.updateData(parcadeDoc, {"isAvailable": false});

    return batch.commit();
  }

  static Future<void> cancel(Reservation reservation) async {
    WriteBatch batch = Firestore.instance.batch();
    var reservationDoc =
        _db.collection("reservations").document(reservation.id);
    batch.updateData(reservationDoc, {"canceledOn": Timestamp.now()});

    var userDoc = _db.collection("users").document(reservation.userId);
    batch.updateData(userDoc, {"currentReservation": ""});

    var parcadeDoc =
        _db.collection("parcades").document(reservation.parcade.id);
    batch.updateData(parcadeDoc, {"isAvailable": true});

    return batch.commit();
  }

  static Future<void> updateArrive(Reservation reservation) async {
    return _db
        .collection('reservations')
        .document(reservation.id)
        .updateData({"arrivedOn": Timestamp.now()});
  }
}
