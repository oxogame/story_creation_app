mixin SignUpValidationMixin {
  String? validateName(String? value) {
    if (value == "" || value == null) {
      return "Name field is required.";
    }
    if (value.length < 7) {
      return "Namespace must be at least 7 long";
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == "" || value == null) {
      return "Email field is required.";
    }
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return null;
    } else {
      return "Please enter a valid email address.";
    }
  }

  String? validatePassword(String? value) {
    if (value == "" || value == null) {
      return "Password field is required.";
    }

    bool isStrong = isPasswordStrong(value);

    if (isStrong) {
      return null;
    } else {
      return "Password is not strong enough.";
    }
  }
}

bool isPasswordStrong(String password) {
  RegExp upperCase = RegExp(r'[A-Z]');
  RegExp lowerCase = RegExp(r'[a-z]');
  RegExp digit = RegExp(r'[0-9]');
  RegExp specialChar = RegExp(r'[@#\$%^&+=]');

  // Check the length
  if (password.length < 8) {
    return false;
  }

  // Check for uppercase letter
  if (!upperCase.hasMatch(password)) {
    return false;
  }

  // Check for lowercase letter
  if (!lowerCase.hasMatch(password)) {
    return false;
  }

  // Check for digit
  if (!digit.hasMatch(password)) {
    return false;
  }

  // Check for special character
  if (!specialChar.hasMatch(password)) {
    return false;
  }

  return true;
}
