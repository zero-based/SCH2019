import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parc/repos/user_repository.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is SignedIn) {
      yield* _mapSignedInToState();
    } else if (event is SignedOut) {
      yield* _mapSignedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await UserRepository.isSignedIn();
      if (isSignedIn) {
        yield Authenticated(await UserRepository.getUser());
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      print(e.toString());
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapSignedInToState() async* {
    yield Authenticated(await UserRepository.getUser());
  }

  Stream<AuthenticationState> _mapSignedOutToState() async* {
    yield Unauthenticated();
    UserRepository.signOut();
  }
}
