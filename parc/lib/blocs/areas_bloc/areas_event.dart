import 'package:equatable/equatable.dart';

import '../../models/area.dart';

abstract class AreasEvent extends Equatable {}

class LoadAreas extends AreasEvent {
  @override
  String toString() => 'LoadAreas';

  @override
  List<Object> get props => [];
}

class UpdateAreas extends AreasEvent {
  final List<Area> areas;

  UpdateAreas(this.areas);

  @override
  String toString() => 'UpdateAreas { areas: $areas }';

  @override
  List<Object> get props => [areas];
}
