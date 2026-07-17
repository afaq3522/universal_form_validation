/// A class that provides date-related validation methods.
class DateValidators {
  /// Validates that the given [value] is a parseable date.
  ///
  /// Accepts ISO 8601 formats such as `2026-07-17` or
  /// `2026-07-17 14:30:00`. [fieldName] is used in the error message,
  /// defaulting to 'Date'.
  static String? date(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (DateTime.tryParse(value.trim()) == null) {
      return 'Enter a valid ${fieldName.toLowerCase()}';
    }

    return null;
  }

  /// Validates that the date of birth in [value] corresponds to an age of
  /// at least [minAge] years.
  ///
  /// The [value] must be an ISO 8601 date such as `2000-05-20`.
  static String? minimumAge(String? value, {int minAge = 18}) {
    if (value == null || value.trim().isEmpty) {
      return 'Date of birth is required';
    }

    final dob = DateTime.tryParse(value.trim());

    if (dob == null) {
      return 'Enter a valid date of birth';
    }

    final now = DateTime.now();

    if (dob.isAfter(now)) {
      return 'Date of birth cannot be in the future';
    }

    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    if (age < minAge) {
      return 'You must be at least $minAge years old';
    }

    return null;
  }

  /// Validates that the date in [value] is not in the future.
  ///
  /// [fieldName] is used in the error message, defaulting to 'Date'.
  static String? notInFuture(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final parsed = DateTime.tryParse(value.trim());

    if (parsed == null) {
      return 'Enter a valid date';
    }

    if (parsed.isAfter(DateTime.now())) {
      return '$fieldName cannot be in the future';
    }

    return null;
  }
}
