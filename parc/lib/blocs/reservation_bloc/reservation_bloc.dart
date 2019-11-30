import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/models/parcade.dart';
import 'package:parc/models/reservation.dart';
import 'package:parc/repos/reservations_repository.dart';

import 'bloc.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  @override
  ReservationState get initialState => Loading();
  StreamSubscription _areasSubscription;

  @override
  Stream<ReservationState> mapEventToState(ReservationEvent event) async* {
    if (event is Fetch) {
      yield* _mapFetchToState(event.reservationId);
    } else if (event is Update) {
      yield* _mapUpdateToState(event.reservation);
    } else if (event is Reserve) {
      yield* _mapReserveToState(event.parcade, event.userId);
    } else if (event is Cancel) {
      yield* _mapCancelToState(event.reservation);
    } else if (event is Arrive) {
      yield* _mapArriveToState(event.reservation);
    }
  }

  Stream<ReservationState> _mapFetchToState(String reservationId) async* {
    if (reservationId == "") {
      yield Free();
    } else {
      _areasSubscription?.cancel();
      _areasSubscription = ReservationRepository.get(reservationId)
          .listen((res) async => add(Update(await res)));
    }
  }

  Stream<ReservationState> _mapUpdateToState(Reservation reservation) async* {
    if (reservation.canceledOn != null) {
      yield Free();
    } else if (reservation.arrivedOn == null) {
      yield Reserved(reservation);
    } else if (reservation.leftOn == null) {
      yield Parked(reservation);
    } else {
      yield Free();
    }
  }

  Stream<ReservationState> _mapReserveToState(
      Parcade parcade, String userId) async* {
    var reservation = Reservation(
      userId: userId,
      parcade: parcade,
      reservedOn: Timestamp.now(),
    );
    await ReservationRepository.make(reservation);
    _areasSubscription?.cancel();
    _areasSubscription = ReservationRepository.get(reservation.id)
        .listen((res) async => add(Update(await res)));
  }

  Stream<ReservationState> _mapCancelToState(Reservation reservation) async* {
    await ReservationRepository.cancel(reservation);
    yield Free();
  }

  Stream<ReservationState> _mapArriveToState(Reservation reservation) async* {
    await ReservationRepository.updateArrive(reservation);
    reservation.arrivedOn = Timestamp.now();
    yield Parked(reservation);
  }
}
