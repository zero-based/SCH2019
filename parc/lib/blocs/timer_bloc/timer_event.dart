import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent();
  @override
  List<int> get props => [];
}

class Start extends TimerEvent {
  final int duration;

  Start({this.duration});
  @override
  List<int> get props => [duration];

  @override
  String toString() => "Start { duration: $duration }";
}

class Reset extends TimerEvent {
  @override
  String toString() => "Reset";
}

class Tick extends TimerEvent {
  final int duration;

  Tick({this.duration});
  @override
  List<int> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}