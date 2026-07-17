/// A class that provides common number-related validation methods.
class NumberValidators {
  /// Validates that the given [value] is a valid number.
  ///
  /// If the [value] is null, empty, or not a valid number, it returns an error message.
  /// [fieldName] is used in the error message, defaulting to 'Number'.
  static String? number(String? value, {String fieldName = 'Number'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (double.tryParse(value.trim()) == null) {
      return '$fieldName must be numeric';
    }

    return null;
  }

  /// Validates that the given [value] is a whole number (integer).
  ///
  /// [fieldName] is used in the error message, defaulting to 'Number'.
  static String? integer(String? value, {String fieldName = 'Number'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (int.tryParse(value.trim()) == null) {
      return '$fieldName must be a whole number';
    }

    return null;
  }

  /// Validates that the given numeric [value] is between [min] and [max].
  ///
  /// Either bound may be omitted. [fieldName] is used in the error message,
  /// defaulting to 'Number'.
  static String? range(
    String? value, {
    num? min,
    num? max,
    String fieldName = 'Number',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final parsed = double.tryParse(value.trim());

    if (parsed == null) {
      return '$fieldName must be numeric';
    }

    if (min != null && parsed < min) {
      return '$fieldName must be at least $min';
    }

    if (max != null && parsed > max) {
      return '$fieldName must not exceed $max';
    }

    return null;
  }

  /// Validates that the given [value] is a valid phone number.
  ///
  /// A valid phone number can optionally start with '+' and may contain
  /// digits, spaces, dashes, dots, and parentheses (e.g. `(555) 123-4567`).
  /// The digit count (excluding formatting) must be between [minLength]
  /// and [maxLength].
  static String? phone(String? value, {int minLength = 7, int maxLength = 15}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final trimmed = value.trim();
    final regex = RegExp(r'^\+?[0-9\s\-.()]+$');

    if (!regex.hasMatch(trimmed)) {
      return 'Enter a valid phone number';
    }

    final digitCount = trimmed.replaceAll(RegExp(r'[^0-9]'), '').length;

    if (digitCount < minLength || digitCount > maxLength) {
      return 'Phone number length is invalid';
    }

    return null;
  }

  /// Validates that the given [value] is a valid credit or debit card number.
  ///
  /// Spaces and dashes are ignored. The number must be 12–19 digits and pass
  /// the Luhn checksum used by all major card networks.
  static String? creditCard(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required';
    }

    final digits = value.replaceAll(RegExp(r'[\s-]'), '');

    if (!RegExp(r'^\d{12,19}$').hasMatch(digits)) {
      return 'Enter a valid card number';
    }

    var sum = 0;
    var doubleDigit = false;

    for (var i = digits.length - 1; i >= 0; i--) {
      var digit = int.parse(digits[i]);

      if (doubleDigit) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }

      sum += digit;
      doubleDigit = !doubleDigit;
    }

    if (sum % 10 != 0) {
      return 'Enter a valid card number';
    }

    return null;
  }
}
