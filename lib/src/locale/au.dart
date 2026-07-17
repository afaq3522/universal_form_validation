import 'country_rules.dart';

/// Validation rules specifically for Australia.
class AustraliaRules implements CountryRules {
  static final _postcodeRegex = RegExp(r'^\d{4}$');

  static const _states = {
    'NSW',
    'VIC',
    'QLD',
    'SA',
    'WA',
    'TAS',
    'NT',
    'ACT',
  };

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postcode is required';
    }

    if (!_postcodeRegex.hasMatch(value.trim())) {
      return 'Invalid Australian postcode';
    }

    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'State is required';
    }

    if (!_states.contains(value.trim().toUpperCase())) {
      return 'Invalid state code';
    }

    return null;
  }
}
