import 'country_rules.dart';

/// Validation rules specifically for Canada.
class CanadaRules implements CountryRules {
  static final _postalRegex = RegExp(
    r'^[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d$',
    caseSensitive: false,
  );

  static const _provinces = {
    'AB',
    'BC',
    'MB',
    'NB',
    'NL',
    'NS',
    'NT',
    'NU',
    'ON',
    'PE',
    'QC',
    'SK',
    'YT',
  };

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }

    if (!_postalRegex.hasMatch(value.trim())) {
      return 'Invalid Canadian postal code';
    }

    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Province is required';
    }

    if (!_provinces.contains(value.trim().toUpperCase())) {
      return 'Invalid province code';
    }

    return null;
  }
}
