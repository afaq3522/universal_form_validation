# Form Validators

[![pub package](https://img.shields.io/pub/v/universal_form_validation)](https://pub.dev/packages/universal_form_validation)

A lightweight, extensible, and country-aware **form validation package** for Flutter & Dart.  
Supports generic validations like email, password, phone, text length, and country-specific postal
code/state rules.

## Features

- ✅ Required field validation
- ✅ Email & password validation
- ✅ Confirm password validation
- ✅ Phone number & numeric input validation
- ✅ Text length validation
- ✅ Street, city, postal code, state/province validation
- ✅ Country-aware (Canada, USA, Generic/Worldwide)
- ✅ Extensible to any country

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  universal_form_validation: ^1.0.0 
```

Then run:

```yaml
flutter pub get
```

## Usage

Basic Validators

```
import 'package:universal_form_validation/universal_form_validation.dart';

String? emailError = BasicValidators.email('example@test.com');
String? passwordError = BasicValidators.password('Secret123!');
```

Text & Number Validators

```
String? nameError = TextValidators.name('Afaq');
String? phoneError = NumberValidators.phone('+1234567890');
```

Address Validators

```
String? cityError = AddressValidators.city('Toronto');
String? streetError = AddressValidators.street('123 Main Street');
```

Country-Specific Validators

```
import 'package:universal_form_validation/universal_form_validation.dart';

final rules = CanadaRules();

String? postalError = rules.postalCode('K1A 0B1');
String? provinceError = rules.stateOrProvince('ON');
```

Switch to USA:

```
final rulesUS = USRules();
String? zipError = rulesUS.postalCode('10001');
String? stateError = rulesUS.stateOrProvince('NY');
```

Generic Worldwide Validators

```
final genericRules = GenericCountryRules();
String? postal = genericRules.postalCode('12345');
String? state = genericRules.stateOrProvince('SomeState');
```

Extending for New Countries

```
class IndiaRules implements CountryRules {
@override
String? postalCode(String? value) {
if (!RegExp(r'^\d{6}$').hasMatch(value ?? '')) {
return 'Invalid postal code';
}
return null;
}

@override
String? stateOrProvince(String? value) {
if (value == null || value.trim().isEmpty) return 'State is required';
return null;
}
}
```

## License

MIT License © 2026