import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLicenseValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isLicenseValid;

  SignUpState({
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isLicenseValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory SignUpState.empty() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isLicenseValid: true,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isLicenseValid: true,
      isSubmitting: true,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isLicenseValid: true,
      isFailure: true,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isLicenseValid: true,
      isSuccess: true,
    );
  }

  SignUpState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isLicenseValid,
    bool isEmailChecked,
    bool isLicenseChecked,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isLicenseValid: isLicenseValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isLicenseValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLicenseValid: isLicenseValid ?? this.isLicenseValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignUpState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isLicenseValid: $isLicenseValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
