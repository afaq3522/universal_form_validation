import 'country_rules.dart';

/// Validation rules specifically for India.
class IndiaRules implements CountryRules {
  static final _pinRegex = RegExp(r'^[1-9]\d{5}$');

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'PIN code is required';
    }

    if (!_pinRegex.hasMatch(value.trim())) {
      return 'Invalid PIN code';
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
