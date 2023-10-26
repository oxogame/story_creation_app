mixin SignInValidationMixin {
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
    } else {
      return null;
    }
  }
}
