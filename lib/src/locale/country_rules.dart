import 'au.dart';
import 'ca.dart';
import 'de.dart';
import 'generic.dart';
import 'in.dart';
import 'pk.dart';
import 'uk.dart';
import 'us.dart';

/// Interface for country-specific validation rules.
abstract class CountryRules {
  /// Validates the postal code for a specific country.
  String? postalCode(String? value);

  /// Validates the state or province for a specific country.
  String? stateOrProvince(String? value);

  /// Returns the [CountryRules] for the given ISO 3166-1 alpha-2
  /// [countryCode] (case-insensitive), e.g. `'US'`, `'CA'`, `'GB'`.
  ///
  /// Falls back to [GenericCountryRules] for unsupported countries, so the
  /// result is always safe to use.
  static CountryRules of(String countryCode) {
    switch (countryCode.trim().toUpperCase()) {
      case 'CA':
        return CanadaRules();
      case 'US':
        return USRules();
      case 'GB':
      case 'UK':
        return UKRules();
      case 'AU':
        return AustraliaRules();
      case 'IN':
        return IndiaRules();
      case 'DE':
        return GermanyRules();
      case 'PK':
        return PakistanRules();
      default:
        return GenericCountryRules();
    }
  }
}
