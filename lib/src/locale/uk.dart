import 'country_rules.dart';

/// Validation rules specifically for the United Kingdom.
class UKRules implements CountryRules {
  static final _postcodeRegex = RegExp(
    r'^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$',
    caseSensitive: false,
  );

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postcode is required';
    }

    if (!_postcodeRegex.hasMatch(value.trim())) {
      return 'Invalid UK postcode';
    }

    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'County is required';
    }

    if (value.trim().length < 2) {
      return 'Enter a valid county';
    }

    return null;
  }
}
