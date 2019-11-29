import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class SignedIn extends AuthenticationEvent {
  @override
  String toString() => 'SignedIn';
}

class SignedOut extends AuthenticationEvent {
  @override
  String toString() => 'SignedOut';
}
