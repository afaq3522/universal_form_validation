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
}
