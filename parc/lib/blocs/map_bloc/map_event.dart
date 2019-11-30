import 'package:equatable/equatable.dart';
import 'package:parc/models/parcade.dart';

abstract class MapEvent extends Equatable {
  MapEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrent extends MapEvent {
  LoadCurrent();
}

class TapMarker extends MapEvent {
  final Parcade parcade;

  TapMarker(this.parcade);

  @override
  List<Object> get props => [parcade];
}

class UnTapMarker extends MapEvent {
  UnTapMarker();
}
