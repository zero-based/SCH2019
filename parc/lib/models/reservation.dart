import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/models/parcade.dart';

class Reservation {
  String id;
  String userId;
  Parcade parcade;
  Timestamp reservedOn;
  Timestamp arrivedOn;
  Timestamp canceledOn;

  Reservation({
    this.id,
    this.userId,
    this.parcade,
    this.reservedOn,
    this.arrivedOn,
    this.canceledOn,
  });

  factory Reservation.fromDocument(DocumentSnapshot doc) {
    return Reservation(
      id: doc['id'],
      userId: doc['userId'],
      parcade: Parcade(id: doc['parcadeId']),
      reservedOn: doc['reservedOn'],
      arrivedOn: doc['arrivedOn'],
      canceledOn: doc['canceledOn'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'parcadeId': parcade.id,
      'reservedOn': reservedOn,
      'arrivedOn': arrivedOn,
      'canceledOn': canceledOn
    };
  }

  @override
  String toString() {
    return '''Reservation{
      'id': $id,
      'userId': $userId,
      'parcade': $parcade,
      'reservedOn': $reservedOn,
      'arrivedOn': $arrivedOn,
      'canceledOn': $canceledOn
    }''';
  }
}
