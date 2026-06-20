/// Extension on String for validation checks
extension StringExt on String {
  /// Check if email is valid
  bool get isValidEmail => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(this);

  /// Check if password is strong (min 6 chars)
  bool get isStrongPassword => length >= 6;

  /// Check if string has minimum length
  bool isMinLength(int minLength) => length >= minLength;
}
