import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repos/area_repository.dart';
import 'bloc.dart';

class AreasBloc extends Bloc<AreasEvent, AreasState> {
  StreamSubscription _areasSubscription;

  @override
  AreasState get initialState => AreasLoading();

  @override
  Stream<AreasState> mapEventToState(AreasEvent event) async* {
    if (event is LoadAreas) {
      yield* _mapLoadAreasToState();
    } else if (event is UpdateAreas) {
      yield AreasLoaded(event.areas);
    }
  }

  Stream<AreasState> _mapLoadAreasToState() async* {
    _areasSubscription?.cancel();
    _areasSubscription =
        AreaRepository.getAreas().listen((areas) => add(UpdateAreas(areas)));
  }
}
