/// A class that provides address-related validation methods.
class AddressValidators {
  /// Validates that the given [value] is a valid street address.
  ///
  /// It checks if the value is not null or empty, and has a minimum length.
  static String? street(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Street address is required';
    }

    if (value.trim().length < 5) {
      return 'Enter a valid street address';
    }

    return null;
  }

  /// Validates that the given [value] is a valid city name.
  ///
  /// It checks if the value is not null or empty, and has a minimum length.
  static String? city(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required';
    }

    if (value.trim().length < 2) {
      return 'Enter a valid city name';
    }

    return null;
  }
}
