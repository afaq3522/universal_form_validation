class TextValidators {
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
