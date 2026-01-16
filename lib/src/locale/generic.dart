import 'country_rules.dart';

class GenericCountryRules implements CountryRules {
  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }

    if (value.trim().length < 3) {
      return 'Enter a valid postal code';
    }

    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'State / Province is required';
    }

    if (value.trim().length < 2) {
      return 'Enter a valid state or province';
    }

    return null;
  }
}
