import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent {
  final String email;

  EmailChanged({this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends SignUpEvent {
  final String password;

  PasswordChanged({this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class LicenseChanged extends SignUpEvent {
  final String license;

  LicenseChanged({this.license});

  @override
  List<Object> get props => [license];

  @override
  String toString() {
    return 'LicenseChanged { license: $license }';
  }
}

class Submitted extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String license;

  Submitted({this.name, this.email, this.password, this.license});

  @override
  List<Object> get props => [name, email, password, license];

  @override
  String toString() {
    return '''Submitted{
      name: $name
      email: $email,
      password: $password,
      license: $license
    }''';
  }
}
