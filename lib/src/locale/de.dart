import 'country_rules.dart';

/// Validation rules specifically for Germany.
class GermanyRules implements CountryRules {
  static final _plzRegex = RegExp(r'^\d{5}$');

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }

    if (!_plzRegex.hasMatch(value.trim())) {
      return 'Invalid German postal code';
    }

    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'State is required';
    }

    if (value.trim().length < 2) {
      return 'Enter a valid state';
    }

    return null;
  }
}
