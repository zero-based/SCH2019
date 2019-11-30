import 'package:equatable/equatable.dart';
import 'package:parc/models/area.dart';

abstract class AreasState extends Equatable {
  @override
  List<Object> get props => [];
}

class AreasLoading extends AreasState {
  @override
  String toString() => 'TransactionLoading';
}

class AreasLoaded extends AreasState {
  final List<Area> areas;

  AreasLoaded(this.areas);

  @override
  String toString() => 'AreasLoaded { Areas: $areas }';

  @override
  List<Object> get props => [areas];
}

class AreasNotLoaded extends AreasState {
  @override
  String toString() => 'AreasNotLoaded';
}
