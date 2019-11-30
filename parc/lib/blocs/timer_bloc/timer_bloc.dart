import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../util/ticker.dart';
import 'bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const INTERVAL = 15 * 60;
  StreamSubscription<int> _tickerSubscription;

  @override
  TimerState get initialState => Ready(INTERVAL);

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event.duration);
    } else if (event is Tick) {
      yield* _mapTickToState(event.duration);
    } else if (event is Reset) {
      yield* _mapResetToState();
    }
  }

  Stream<TimerState> _mapStartToState(int duration) async* {
    yield Running(duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = Ticker.tick(ticks: duration).listen(
      (duration) {
        add(Tick(duration: duration));
      },
    );
  }

  Stream<TimerState> _mapTickToState(int duration) async* {
    yield duration > 0 ? Running(duration) : Finished();
  }

  Stream<TimerState> _mapResetToState() async* {
    _tickerSubscription?.cancel();
    yield Ready(INTERVAL);
  }

  @override
  Future<void> close() async {
    _tickerSubscription?.cancel();
    await super.close();
  }
}
