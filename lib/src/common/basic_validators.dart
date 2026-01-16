class BasicValidators {
  static String? required(
      String? value, {
        String fieldName = 'Field',
      }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final regex =
    RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? password(
      String? value, {
        int minLength = 8,
        bool requireUppercase = false,
        bool requireLowercase = false,
        bool requireNumber = false,
        bool requireSpecialChar = false,
      }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain a lowercase letter';
    }

    if (requireNumber && !value.contains(RegExp(r'\d'))) {
      return 'Password must contain a number';
    }

    if (requireSpecialChar &&
        !value.contains(RegExp(r'[!@#\$&*~]'))) {
      return 'Password must contain a special character';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String? original,
      ) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != original) {
      return 'Passwords do not match';
    }

    return null;
  }
}
