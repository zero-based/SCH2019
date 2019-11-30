import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Recharge extends BalanceEvent {
  final double amount;

  Recharge(this.amount);
  @override
  List<Object> get props => [amount];

  @override
  String toString() => 'Recharge { amount: $amount }';
}
