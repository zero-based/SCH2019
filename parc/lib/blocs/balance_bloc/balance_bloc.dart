import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parc/repos/user_repository.dart';

import '../../models/user.dart';

import 'bloc.dart';

class BalanceBloc extends Bloc<BalanceEvent, double> {
  final User user;

  BalanceBloc(this.user);

  @override
  double get initialState => 0;

  @override
  Stream<double> mapEventToState(BalanceEvent event) async* {
    if (event is Recharge) {
      print("Event recharge : ${user.balance}");
      UserRepository.setBalance(
        event.amount,
        user,
      );
    }
  }
}
