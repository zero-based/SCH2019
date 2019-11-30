import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:parc/blocs/timer_bloc/bloc.dart';

@immutable
abstract class TimerEvent extends Equatable {}

class Start extends TimerEvent {
  final int duration;

  Start({this.duration = TimerBloc.INTERVAL});

  @override
  List<int> get props => [duration];

  @override
  String toString() => "Start { duration: $duration }";
}

class Tick extends TimerEvent {
  final int duration;

  Tick({this.duration});

  @override
  List<int> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}

class Reset extends TimerEvent {
  Reset();

  @override
  String toString() => "Reset";

  @override
  List<int> get props => [];
}
