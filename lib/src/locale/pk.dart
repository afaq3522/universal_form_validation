import 'country_rules.dart';

/// Validation rules specifically for Pakistan.
class PakistanRules implements CountryRules {
  static final _postalRegex = RegExp(r'^\d{5}$');

  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }

    if (!_postalRegex.hasMatch(value.trim())) {
      return 'Invalid Pakistani postal code';
    }

    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Province is required';
    }

    if (value.trim().length < 2) {
      return 'Enter a valid province';
    }

    return null;
  }
}
