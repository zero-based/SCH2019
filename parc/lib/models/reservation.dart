import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String id;
  final String userId;
  final String parcadeId;
  final bool arrived;
  final Timestamp reservationTimestamp;
  final Timestamp arrivalTimestamp;
  final Timestamp cancelationTimestamp;

  Reservation(
      {this.id,
      this.userId,
      this.parcadeId,
      this.arrived,
      this.reservationTimestamp,
      this.arrivalTimestamp,
      this.cancelationTimestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'parcadeId': parcadeId,
      'arrived': arrived,
      'reservationTimestamp': reservationTimestamp,
      'arrivalTimestamp': arrivalTimestamp,
      'cancelationTimestamp': cancelationTimestamp
    };
  }

  @override
  String toString() {
    return '''Reservation{
      'id': $id,
      'userId': $userId,
      'parcadeId': $parcadeId,
      'arrived': $arrived,
      'reservationTimestamp': $reservationTimestamp,
      'arrivalTimestamp': $arrivalTimestamp,
      'cancelationTimestamp': $cancelationTimestamp
    }''';
  }
}
