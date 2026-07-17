/// A class that provides text-related validation methods.
class TextValidators {
  /// Validates that the given [value] is a valid name.
  ///
  /// Checks if the value is not null or empty, and has a minimum length of [minLength].
  /// [fieldName] is used in the error message, defaulting to 'Name'.
  static String? name(
    String? value, {
    int minLength = 2,
    String fieldName = 'Name',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Validates the length of the given [value].
  ///
  /// Checks if the length is between [min] and [max].
  /// [fieldName] is used in the error message, defaulting to 'Field'.
  static String? length(
    String? value, {
    int? min,
    int? max,
    String fieldName = 'Field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final len = value.trim().length;

    if (min != null && len < min) {
      return '$fieldName must be at least $min characters';
    }

    if (max != null && len > max) {
      return '$fieldName must not exceed $max characters';
    }

    return null;
  }

  /// Validates that the given [value] is a valid username.
  ///
  /// A valid username contains only letters, numbers, dots, dashes, and
  /// underscores, starts with a letter or number, and is between
  /// [minLength] and [maxLength] characters long.
  static String? username(
    String? value, {
    int minLength = 3,
    int maxLength = 30,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < minLength || trimmed.length > maxLength) {
      return 'Username must be $minLength-$maxLength characters';
    }

    if (!RegExp(r'^[A-Za-z0-9][A-Za-z0-9._-]*$').hasMatch(trimmed)) {
      return 'Username can only contain letters, numbers, dots, dashes and underscores';
    }

    return null;
  }

  /// Validates that the given [value] contains only letters and numbers.
  ///
  /// [fieldName] is used in the error message, defaulting to 'Field'.
  static String? alphanumeric(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value.trim())) {
      return '$fieldName must contain only letters and numbers';
    }

    return null;
  }
}
