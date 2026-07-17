## 1.0.0

First stable release. 🎉

**New validators**
- `BasicValidators.url` — HTTP/HTTPS URL validation with optional scheme
- `BasicValidators.pattern` — validate against any custom `RegExp`
- `TextValidators.username` and `TextValidators.alphanumeric`
- `NumberValidators.integer`, `NumberValidators.range` (min/max)
- `NumberValidators.creditCard` — Luhn checksum card validation
- `DateValidators` — `date`, `minimumAge` (e.g. 18+), `notInFuture`
- `FormValidators.compose` — chain multiple validators per field
- `FormValidators.optional` — skip validation for empty optional fields

**New countries**
- 🇬🇧 `UKRules`, 🇦🇺 `AustraliaRules`, 🇮🇳 `IndiaRules`, 🇩🇪 `GermanyRules`, 🇵🇰 `PakistanRules`
- `CountryRules.of('US')` — look up rules by ISO country code with a safe generic fallback

**Improvements**
- Package is now **pure Dart** with zero dependencies — usable in Flutter (all platforms), server, CLI, and web projects
- `NumberValidators.phone` now accepts formatted numbers such as `(555) 123-4567` and `+1 555 123 4567`; length is checked on digits only
- Password special-character check now accepts any non-alphanumeric character
- Broader SDK compatibility (`sdk: ^3.4.0`)
- Complete runnable Flutter example app
- Expanded test suite and documentation

## 0.0.4
- Updated repository and homepage URLs

## 0.0.3
- Complete documentation for public members
- MIT Licence
