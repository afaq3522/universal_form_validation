/// A class that provides basic common validation methods.
class BasicValidators {
  /// Validates that the given [value] is not null or empty.
  ///
  /// [fieldName] is used in the error message, defaulting to 'Field'.
  static String? required(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates that the given [value] is a valid email address.
  ///
  /// It checks for a basic email pattern.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final regex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  /// Validates that the given [value] meets password strength requirements.
  ///
  /// Customizable requirements include [minLength], [requireUppercase],
  /// [requireLowercase], [requireNumber], and [requireSpecialChar].
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

    if (requireSpecialChar && !value.contains(RegExp(r'[^A-Za-z0-9]'))) {
      return 'Password must contain a special character';
    }

    return null;
  }

  /// Validates that the given [value] is a valid URL.
  ///
  /// By default only `http` and `https` URLs are accepted. Set
  /// [requireScheme] to `false` to also accept URLs without a scheme,
  /// such as `example.com`.
  static String? url(String? value, {bool requireScheme = true}) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }

    var input = value.trim();

    if (!requireScheme && !input.contains('://')) {
      input = 'https://$input';
    }

    final uri = Uri.tryParse(input);

    if (uri == null ||
        !(uri.scheme == 'http' || uri.scheme == 'https') ||
        uri.host.isEmpty ||
        !uri.host.contains('.')) {
      return 'Enter a valid URL';
    }

    return null;
  }

  /// Validates that the given [value] matches the provided [pattern].
  ///
  /// [errorMessage] is returned when the pattern does not match.
  static String? pattern(
    String? value,
    Pattern pattern, {
    String errorMessage = 'Invalid format',
    String fieldName = 'Field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final regex = pattern is RegExp ? pattern : RegExp(pattern.toString());

    if (!regex.hasMatch(value.trim())) {
      return errorMessage;
    }

    return null;
  }

  /// Validates that [value] matches [original].
  ///
  /// Useful for "confirm password" fields.
  static String? confirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != original) {
      return 'Passwords do not match';
    }

    return null;
  }
}
