# Universal Form Validation

[![pub package](https://img.shields.io/pub/v/universal_form_validation)](https://pub.dev/packages/universal_form_validation)
[![pub points](https://img.shields.io/pub/points/universal_form_validation)](https://pub.dev/packages/universal_form_validation/score)
[![license: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/afaq35202/universal_form_validation/blob/main/LICENSE)

A lightweight, **pure Dart**, country-aware form validation library — zero dependencies, works everywhere Dart runs: Flutter (all platforms), server, CLI, and web.

Every validator returns `String?` (an error message or `null`), so it plugs straight into Flutter's `TextFormField.validator`.

## Features

- ✅ Required, email, password & confirm-password validation
- ✅ Username, name, text length & alphanumeric validation
- ✅ Phone numbers (accepts `(555) 123-4567`, `+1 555 123 4567`, …)
- ✅ Numbers: numeric, integer, min/max range
- ✅ Credit / debit card numbers (Luhn checksum)
- ✅ URLs and custom regex patterns
- ✅ Dates: valid date, minimum age (e.g. 18+), not-in-future
- ✅ Address: street, city, postal code, state/province
- ✅ Country-aware: 🇺🇸 US, 🇨🇦 Canada, 🇬🇧 UK, 🇦🇺 Australia, 🇮🇳 India, 🇩🇪 Germany, 🇵🇰 Pakistan + generic worldwide fallback
- ✅ Composable validators (`compose`, `optional`)
- ✅ Extensible to any country
- ✅ Pure Dart — no Flutter dependency, zero third-party dependencies

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  universal_form_validation: ^1.0.0
```

Then run:

```sh
flutter pub get   # or: dart pub get
```

## Quick start with Flutter

```dart
import 'package:universal_form_validation/universal_form_validation.dart';

TextFormField(
  decoration: const InputDecoration(labelText: 'Email'),
  validator: BasicValidators.email, // tear-off works directly
)

TextFormField(
  decoration: const InputDecoration(labelText: 'Password'),
  obscureText: true,
  validator: (v) => BasicValidators.password(
    v,
    minLength: 8,
    requireUppercase: true,
    requireNumber: true,
    requireSpecialChar: true,
  ),
)
```

## Basic validators

```dart
BasicValidators.required('', fieldName: 'City');  // 'City is required'
BasicValidators.email('example@test.com');        // null (valid)
BasicValidators.password('Secret123!');           // null (valid)
BasicValidators.confirmPassword('abc', 'abcd');   // 'Passwords do not match'
BasicValidators.url('https://dart.dev');          // null (valid)
BasicValidators.url('dart.dev', requireScheme: false); // null (valid)
BasicValidators.pattern('AB-12', RegExp(r'^[A-Z]{2}-\d{2}$'),
    errorMessage: 'Use the format XX-00');
```

## Text & number validators

```dart
TextValidators.name('Afaq');                 // null (valid)
TextValidators.username('afaq_35202');       // null (valid)
TextValidators.length('abc', min: 3, max: 5);
TextValidators.alphanumeric('abc123');

NumberValidators.number('3.14');             // null (valid)
NumberValidators.integer('42');              // null (valid)
NumberValidators.range('5', min: 1, max: 10, fieldName: 'Quantity');
NumberValidators.phone('(555) 123-4567');    // null (valid)
NumberValidators.creditCard('4242 4242 4242 4242'); // Luhn-checked
```

## Date validators

```dart
DateValidators.date('2026-07-17');           // null (valid)
DateValidators.minimumAge('2010-05-20', minAge: 18); // 'You must be at least 18 years old'
DateValidators.notInFuture('2030-01-01');    // 'Date cannot be in the future'
```

## Composing validators

Chain multiple rules for one field, or make a field optional:

```dart
TextFormField(
  validator: FormValidators.compose([
    (v) => BasicValidators.required(v, fieldName: 'Email'),
    BasicValidators.email,
  ]),
)

// Only validated when the user actually enters something:
TextFormField(
  validator: FormValidators.optional(BasicValidators.url),
)
```

## Country-aware address validation

Look up rules by ISO country code — unknown countries automatically fall back to generic worldwide rules:

```dart
final rules = CountryRules.of('CA'); // 'US', 'GB', 'AU', 'IN', 'DE', 'PK', ...

rules.postalCode('K1A 0B1');     // null (valid Canadian postal code)
rules.stateOrProvince('ON');     // null (valid province)
```

Or instantiate a country directly:

```dart
final us = USRules();
us.postalCode('10001');          // null
us.stateOrProvince('NY');        // null

final uk = UKRules();
uk.postalCode('SW1A 1AA');       // null

final generic = GenericCountryRules(); // worldwide fallback
generic.postalCode('12345');     // null
```

### Supported countries

| Country | Class | Postal code | State/Province |
|---|---|---|---|
| 🇺🇸 United States | `USRules` | ZIP / ZIP+4 | 50 state codes |
| 🇨🇦 Canada | `CanadaRules` | `A1A 1A1` format | 13 province/territory codes |
| 🇬🇧 United Kingdom | `UKRules` | Full postcode format | County (basic) |
| 🇦🇺 Australia | `AustraliaRules` | 4 digits | 8 state/territory codes |
| 🇮🇳 India | `IndiaRules` | 6-digit PIN | State (basic) |
| 🇩🇪 Germany | `GermanyRules` | 5 digits | State (basic) |
| 🇵🇰 Pakistan | `PakistanRules` | 5 digits | Province (basic) |
| 🌍 Anywhere else | `GenericCountryRules` | Length check | Length check |

### Adding your own country

Implement `CountryRules`:

```dart
class FranceRules implements CountryRules {
  @override
  String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }
    if (!RegExp(r'^\d{5}$').hasMatch(value.trim())) {
      return 'Invalid postal code';
    }
    return null;
  }

  @override
  String? stateOrProvince(String? value) {
    if (value == null || value.trim().isEmpty) return 'Region is required';
    return null;
  }
}
```

Want a country added to the package? [Open an issue](https://github.com/afaq35202/universal_form_validation/issues) or send a PR — contributions are welcome!

## Example app

A complete Flutter sign-up form using every validator lives in the [`example`](https://github.com/afaq35202/universal_form_validation/tree/main/example) directory.

## License

MIT License — see [LICENSE](https://github.com/afaq35202/universal_form_validation/blob/main/LICENSE).
