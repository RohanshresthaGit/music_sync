class RegexPatterns {
  const RegexPatterns._();

  static final email = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');

  static final phone = RegExp(r'^\d{10}$');

  static final uppercase = RegExp(r'[A-Z]');

  static final lowercase = RegExp(r'[a-z]');

  static final number = RegExp(r'[0-9]');

  static final specialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
}
