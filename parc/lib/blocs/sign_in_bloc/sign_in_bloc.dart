import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../repos/user_repository.dart';
import '../../util/validators.dart';
import 'bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => SignInState.empty();

  @override
  Stream<SignInState> transformEvents(
    Stream<SignInEvent> events,
    Stream<SignInState> Function(SignInEvent event) next,
  ) {
    final observableStream = events as Observable<SignInEvent>;
    final nonDebounceStream = observableStream
        .where((event) => event is! EmailChanged && event is! PasswordChanged);
    final debounceStream = observableStream
        .where((event) => event is EmailChanged || event is PasswordChanged)
        .debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SignInState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignInState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignInState> _mapSubmittedToState({
    String email,
    String password,
  }) async* {
    yield SignInState.loading();
    try {
      await UserRepository.signIn(email, password);
      yield SignInState.success();
    } catch (_) {
      yield SignInState.failure();
    }
  }
}
