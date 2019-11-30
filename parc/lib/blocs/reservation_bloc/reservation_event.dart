import 'package:equatable/equatable.dart';
import 'package:parc/models/parcade.dart';
import 'package:parc/models/reservation.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class Fetch extends ReservationEvent {
  final String reservationId;
  Fetch(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}

class Reserve extends ReservationEvent {
  final Parcade parcade;
  final String userId;

  Reserve(this.parcade, this.userId);

  @override
  List<Object> get props => [parcade, userId];
}

class Arrive extends ReservationEvent {
  final Reservation reservation;

  Arrive(this.reservation);

  @override
  List<Object> get props => [reservation];
}

class Cancel extends ReservationEvent {
  final Reservation reservation;

  Cancel(this.reservation);

  @override
  List<Object> get props => [reservation];
}
