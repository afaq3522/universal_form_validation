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

    if (double.tryParse(value) == null) {
      return '$fieldName must be numeric';
    }

    return null;
  }

  /// Validates that the given [value] is a valid phone number.
  ///
  /// A valid phone number can optionally start with '+' and must contain only digits.
  /// It also checks if the length is between [minLength] and [maxLength].
  static String? phone(String? value, {int minLength = 7, int maxLength = 15}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final regex = RegExp(r'^\+?[0-9]+$');

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }

    if (value.length < minLength || value.length > maxLength) {
      return 'Phone number length is invalid';
    }

    return null;
  }
}
