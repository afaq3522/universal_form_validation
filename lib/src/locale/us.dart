import 'country_rules.dart';

/// Validation rules specifically for the United States.
class USRules implements CountryRules {
  static final _zipRegex = RegExp(r'^\d{5}(-\d{4})?$');

  static const _states = {
    'AL',
    'AK',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DE',
    'FL',
    'GA',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'OH',
    'OK',
    'OR',
    'PA',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY',
  };

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'ZIP code is required';
    }

    if (!_zipRegex.hasMatch(value.trim())) {
      return 'Invalid ZIP code';
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
