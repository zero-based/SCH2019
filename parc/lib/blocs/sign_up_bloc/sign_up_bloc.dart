import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../repos/user_repository.dart';
import '../../util/validators.dart';
import 'bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  @override
  SignUpState get initialState => SignUpState.empty();

  @override
  Stream<SignUpState> transformEvents(
    Stream<SignUpEvent> events,
    Stream<SignUpState> Function(SignUpEvent event) next,
  ) {
    final observableStream = events as Observable<SignUpEvent>;
    final nonDebounceStream = observableStream.where((event) =>
        event is! EmailChanged &&
        event is! PasswordChanged &&
        event is! LicenseChanged);
    final debounceStream = observableStream
        .where((event) =>
            event is EmailChanged ||
            event is PasswordChanged ||
            event is LicenseChanged)
        .debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LicenseChanged) {
      yield* _mapLicenseChangedToState(event.license);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        name: event.name,
        email: event.email,
        password: event.password,
        license: event.license,
      );
    }
  }

  Stream<SignUpState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignUpState> _mapLicenseChangedToState(String license) async* {
    yield state.update(
      isLicenseValid: Validators.isValidLicense(license),
    );
  }

   Stream<SignUpState> _mapFormSubmittedToState({
    String name,
    String email,
    String password,
    String license,
  }) async* {
    yield SignUpState.loading();
    try {
      await UserRepository.signUp(
        name: name,
        email: email,
        password: password,
        license: license,
        balance: 0.0
      );
      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
    }
  }
}
