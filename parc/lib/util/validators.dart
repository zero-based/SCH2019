enum MODE { TEST, DEPLOY }

final mode = MODE.TEST;

class _ValidatorsTestMode {
  static final RegExp emailRegExp = RegExp(
    r'^.+@.+$',
  );

  static final RegExp passwordRegExp = RegExp(
    r'^.{3,}$',
  );

  static final RegExp licenseRegExp = RegExp(
    r'^.{3,}$',
  );
}

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _licenseRegExp = RegExp(
    r'^\d{14}$',
  );

  static isValidEmail(String email) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.emailRegExp.hasMatch(email)
        : _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.passwordRegExp.hasMatch(password)
        : _passwordRegExp.hasMatch(password);
  }

  static isValidLicense(String license) {
    return mode == MODE.TEST
        ? _ValidatorsTestMode.licenseRegExp.hasMatch(license)
        : _licenseRegExp.hasMatch(license);
  }
}
