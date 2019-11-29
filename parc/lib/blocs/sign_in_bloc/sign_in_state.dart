import 'package:meta/meta.dart';

@immutable
class SignInState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  SignInState({
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory SignInState.empty() {
    return SignInState(isEmailValid: true, isPasswordValid: true);
  }

  factory SignInState.loading() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
    );
  }

  factory SignInState.failure() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isFailure: true,
    );
  }

  factory SignInState.success() {
    return SignInState(
      isEmailValid: true,
      isPasswordValid: true,
      isSuccess: true,
    );
  }

  SignInState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignInState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignInState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignInState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
