/// Interface for country-specific validation rules.
abstract class CountryRules {
  /// Validates the postal code for a specific country.
  String? postalCode(String? value);

  /// Validates the state or province for a specific country.
  String? stateOrProvince(String? value);
}
