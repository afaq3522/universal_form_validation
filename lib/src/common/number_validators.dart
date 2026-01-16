class NumberValidators {
  static String? number(
      String? value, {
        String fieldName = 'Number',
      }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (double.tryParse(value) == null) {
      return '$fieldName must be numeric';
    }

    return null;
  }

  static String? phone(
      String? value, {
        int minLength = 7,
        int maxLength = 15,
      }) {
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
