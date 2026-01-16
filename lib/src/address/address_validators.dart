class AddressValidators {
  static String? street(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Street address is required';
    }

    if (value.trim().length < 5) {
      return 'Enter a valid street address';
    }

    return null;
  }

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
