import 'package:music_sync/core/utils/validators/regex_patterns.dart';
import 'package:music_sync/core/utils/validators/validation_messages.dart';
import 'package:music_sync/core/utils/validators/validator_typedef.dart';

class Validators {
  Validators._();

  static Validator required(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return "$fieldName is required.";
      }
      return null;
    };
  }

  static Validator email() {
    return (value) {
      if (!RegexPatterns.email.hasMatch(value ?? '')) {
        return ValidationMessages.inalidEmail;
      }
      return null;
    };
  }

  static Validator minLength(int length) {
    return (value) {
      if ((value ?? '').length < length) {
        return 'Minimum $length characters required';
      }
      return null;
    };
  }

  static Validator maxLength(int length) {
    return (value) {
      if ((value ?? '').length > length) {
        return 'Maximum $length charecters allowed.';
      }
      return null;
    };
  }

  static Validator phone() {
    return (value) {
      if (!RegexPatterns.phone.hasMatch(value ?? '')) {
        return 'Invalid phone number';
      }

      return null;
    };
  }

  static Validator strongPassword() {
    return (value) {
      final password = value ?? '';

      if (!RegexPatterns.uppercase.hasMatch(password)) {
        return 'Must contain uppercase letter';
      }

      if (!RegexPatterns.lowercase.hasMatch(password)) {
        return 'Must contain lowercase letter';
      }

      if (!RegexPatterns.number.hasMatch(password)) {
        return 'Must contain a number';
      }

      if (!RegexPatterns.specialCharacter.hasMatch(password)) {
        return 'Must contain special character';
      }

      return null;
    };
  }

  static Validator match(String Function() getCompareValu) {
    return (value) {
      if (value != getCompareValu().trim()) {
        return "Values doesnot match";
      }
      return null;
    };
  }

  static Validator combine(List<Validator> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);

        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}
