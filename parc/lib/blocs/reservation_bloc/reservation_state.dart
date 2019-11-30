import 'package:equatable/equatable.dart';
import 'package:parc/models/reservation.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();
}

class Loading extends ReservationState {
  @override
  List<Object> get props => [];
}

class Reserved extends ReservationState {
  final Reservation reservation;

  Reserved(this.reservation);

  @override
  List<Object> get props => [reservation];
}

class Parked extends ReservationState {
  final Reservation reservation;

  Parked(this.reservation);

  @override
  List<Object> get props => [reservation];
}

class Free extends ReservationState {
  @override
  List<Object> get props => [];
}
