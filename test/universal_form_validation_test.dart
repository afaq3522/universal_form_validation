import 'package:test/test.dart';

import 'package:universal_form_validation/universal_form_validation.dart';

void main() {
  group('BasicValidators', () {
    test('Required field', () {
      expect(BasicValidators.required(''), 'Field is required');
      expect(BasicValidators.required('Some value'), null);
    });

    test('Email validation', () {
      expect(BasicValidators.email(''), 'Email is required');
      expect(BasicValidators.email('bademail'), 'Enter a valid email address');
      expect(BasicValidators.email('test@test.com'), null);
    });

    test('Password validation', () {
      // Default minLength = 8
      expect(BasicValidators.password(''), 'Password is required');
      expect(BasicValidators.password('1234567'),
          'Password must be at least 8 characters');
      expect(
        BasicValidators.password('Abcdef12!',
            requireUppercase: true,
            requireNumber: true,
            requireSpecialChar: true),
        null,
      );
      // Missing uppercase
      expect(
        BasicValidators.password('abcdef12!', requireUppercase: true),
        'Password must contain an uppercase letter',
      );
      // Missing number
      expect(
        BasicValidators.password('Abcdefgh!', requireNumber: true),
        'Password must contain a number',
      );
      // Missing special character
      expect(
        BasicValidators.password('Abcdef12', requireSpecialChar: true),
        'Password must contain a special character',
      );
    });

    test('Confirm password', () {
      expect(BasicValidators.confirmPassword('', '1234'),
          'Confirm password is required');
      expect(BasicValidators.confirmPassword('123', '1234'),
          'Passwords do not match');
      expect(BasicValidators.confirmPassword('1234', '1234'), null);
    });

    test('URL validation', () {
      expect(BasicValidators.url(''), 'URL is required');
      expect(BasicValidators.url('not a url'), 'Enter a valid URL');
      expect(BasicValidators.url('example.com'), 'Enter a valid URL');
      expect(BasicValidators.url('https://example.com'), null);
      expect(BasicValidators.url('http://example.com/path?q=1'), null);
      expect(BasicValidators.url('example.com', requireScheme: false), null);
      expect(BasicValidators.url('ftp://example.com'), 'Enter a valid URL');
    });

    test('Pattern validation', () {
      expect(
        BasicValidators.pattern('', RegExp(r'^\d+$'), fieldName: 'Code'),
        'Code is required',
      );
      expect(
        BasicValidators.pattern('abc', RegExp(r'^\d+$'),
            errorMessage: 'Digits only'),
        'Digits only',
      );
      expect(BasicValidators.pattern('123', RegExp(r'^\d+$')), null);
    });
  });

  group('FormValidators', () {
    test('compose returns first error', () {
      final validator = FormValidators.compose([
        (v) => BasicValidators.required(v, fieldName: 'Email'),
        BasicValidators.email,
      ]);

      expect(validator(''), 'Email is required');
      expect(validator('bademail'), 'Enter a valid email address');
      expect(validator('test@test.com'), null);
    });

    test('optional skips empty values', () {
      final validator = FormValidators.optional(BasicValidators.email);

      expect(validator(''), null);
      expect(validator(null), null);
      expect(validator('bademail'), 'Enter a valid email address');
      expect(validator('test@test.com'), null);
    });
  });

  group('TextValidators', () {
    test('Name validation', () {
      expect(TextValidators.name(''), 'Name is required');
      expect(TextValidators.name('A'), 'Name must be at least 2 characters');
      expect(TextValidators.name('Afaq'), null);
    });

    test('Text length', () {
      expect(TextValidators.length('', min: 3, max: 5, fieldName: 'TestField'),
          'TestField is required');
      expect(
          TextValidators.length('ab', min: 3, max: 5, fieldName: 'TestField'),
          'TestField must be at least 3 characters');
      expect(
          TextValidators.length('abcdef',
              min: 3, max: 5, fieldName: 'TestField'),
          'TestField must not exceed 5 characters');
      expect(
          TextValidators.length('abc', min: 3, max: 5, fieldName: 'TestField'),
          null);
    });

    test('Username validation', () {
      expect(TextValidators.username(''), 'Username is required');
      expect(TextValidators.username('ab'), 'Username must be 3-30 characters');
      expect(
        TextValidators.username('_afaq'),
        'Username can only contain letters, numbers, dots, dashes and underscores',
      );
      expect(
        TextValidators.username('afaq!'),
        'Username can only contain letters, numbers, dots, dashes and underscores',
      );
      expect(TextValidators.username('afaq_35202'), null);
      expect(TextValidators.username('afaq.awan'), null);
    });

    test('Alphanumeric validation', () {
      expect(TextValidators.alphanumeric('', fieldName: 'Code'),
          'Code is required');
      expect(TextValidators.alphanumeric('abc-123', fieldName: 'Code'),
          'Code must contain only letters and numbers');
      expect(TextValidators.alphanumeric('abc123'), null);
    });
  });

  group('NumberValidators', () {
    test('Number validation', () {
      expect(NumberValidators.number('', fieldName: 'Age'), 'Age is required');
      expect(
          NumberValidators.number('abc', fieldName: 'Age'), 'Age must be numeric');
      expect(NumberValidators.number('123', fieldName: 'Age'), null);
    });

    test('Integer validation', () {
      expect(NumberValidators.integer('', fieldName: 'Age'), 'Age is required');
      expect(NumberValidators.integer('1.5', fieldName: 'Age'),
          'Age must be a whole number');
      expect(NumberValidators.integer('42', fieldName: 'Age'), null);
    });

    test('Range validation', () {
      expect(NumberValidators.range('', min: 1, max: 10, fieldName: 'Qty'),
          'Qty is required');
      expect(NumberValidators.range('abc', min: 1, fieldName: 'Qty'),
          'Qty must be numeric');
      expect(NumberValidators.range('0', min: 1, fieldName: 'Qty'),
          'Qty must be at least 1');
      expect(NumberValidators.range('11', max: 10, fieldName: 'Qty'),
          'Qty must not exceed 10');
      expect(NumberValidators.range('5', min: 1, max: 10), null);
    });

    test('Phone validation', () {
      expect(NumberValidators.phone(''), 'Phone number is required');
      expect(NumberValidators.phone('abc'), 'Enter a valid phone number');
      expect(NumberValidators.phone('12345'), 'Phone number length is invalid');
      expect(NumberValidators.phone('+1234567890'), null);
      expect(NumberValidators.phone('1234567'), null);
      // Formatted numbers are accepted; only digits are counted.
      expect(NumberValidators.phone('(555) 123-4567'), null);
      expect(NumberValidators.phone('+1 555 123 4567'), null);
    });

    test('Credit card validation', () {
      expect(NumberValidators.creditCard(''), 'Card number is required');
      expect(NumberValidators.creditCard('1234'), 'Enter a valid card number');
      // Fails the Luhn checksum
      expect(NumberValidators.creditCard('4242424242424241'),
          'Enter a valid card number');
      // Valid test numbers (Visa, Mastercard) with and without formatting
      expect(NumberValidators.creditCard('4242424242424242'), null);
      expect(NumberValidators.creditCard('4242 4242 4242 4242'), null);
      expect(NumberValidators.creditCard('5555-5555-5555-4444'), null);
    });
  });

  group('DateValidators', () {
    test('Date validation', () {
      expect(DateValidators.date(''), 'Date is required');
      expect(DateValidators.date('not-a-date'), 'Enter a valid date');
      expect(DateValidators.date('2026-07-17'), null);
    });

    test('Minimum age validation', () {
      expect(DateValidators.minimumAge(''), 'Date of birth is required');
      expect(DateValidators.minimumAge('nope'), 'Enter a valid date of birth');

      final now = DateTime.now();
      final tenYearsAgo =
          DateTime(now.year - 10, now.month, now.day).toIso8601String();
      final thirtyYearsAgo =
          DateTime(now.year - 30, now.month, now.day).toIso8601String();
      final tomorrow = now.add(const Duration(days: 1)).toIso8601String();

      expect(DateValidators.minimumAge(tenYearsAgo),
          'You must be at least 18 years old');
      expect(DateValidators.minimumAge(thirtyYearsAgo), null);
      expect(DateValidators.minimumAge(tomorrow),
          'Date of birth cannot be in the future');
    });

    test('Not in future validation', () {
      final tomorrow =
          DateTime.now().add(const Duration(days: 1)).toIso8601String();

      expect(DateValidators.notInFuture(''), 'Date is required');
      expect(DateValidators.notInFuture(tomorrow), 'Date cannot be in the future');
      expect(DateValidators.notInFuture('2020-01-01'), null);
    });
  });

  group('AddressValidators', () {
    test('Street validation', () {
      expect(AddressValidators.street(''), 'Street address is required');
      expect(AddressValidators.street('1234'), 'Enter a valid street address');
      expect(AddressValidators.street('12345 Main St'), null);
    });

    test('City validation', () {
      expect(AddressValidators.city(''), 'City is required');
      expect(AddressValidators.city('A'), 'Enter a valid city name');
      expect(AddressValidators.city('Toronto'), null);
    });
  });

  group('CountryRules', () {
    final canada = CanadaRules();
    final us = USRules();
    final uk = UKRules();
    final australia = AustraliaRules();
    final india = IndiaRules();
    final germany = GermanyRules();
    final pakistan = PakistanRules();
    final generic = GenericCountryRules();

    test('Canada postal code', () {
      expect(canada.postalCode(''), 'Postal code is required');
      expect(canada.postalCode('123'), 'Invalid Canadian postal code');
      expect(canada.postalCode('K1A 0B1'), null);
    });

    test('Canada province', () {
      expect(canada.stateOrProvince(''), 'Province is required');
      expect(canada.stateOrProvince('XX'), 'Invalid province code');
      expect(canada.stateOrProvince('ON'), null);
    });

    test('US ZIP code', () {
      expect(us.postalCode(''), 'ZIP code is required');
      expect(us.postalCode('abc'), 'Invalid ZIP code');
      expect(us.postalCode('10001'), null);
      expect(us.postalCode('12345-6789'), null);
    });

    test('US state', () {
      expect(us.stateOrProvince(''), 'State is required');
      expect(us.stateOrProvince('XX'), 'Invalid state code');
      expect(us.stateOrProvince('NY'), null);
    });

    test('UK postcode', () {
      expect(uk.postalCode(''), 'Postcode is required');
      expect(uk.postalCode('12345'), 'Invalid UK postcode');
      expect(uk.postalCode('SW1A 1AA'), null);
      expect(uk.postalCode('M1 1AE'), null);
      expect(uk.postalCode('EC1A 1BB'), null);
    });

    test('Australia postcode and state', () {
      expect(australia.postalCode('200'), 'Invalid Australian postcode');
      expect(australia.postalCode('2000'), null);
      expect(australia.stateOrProvince('XX'), 'Invalid state code');
      expect(australia.stateOrProvince('NSW'), null);
    });

    test('India PIN code', () {
      expect(india.postalCode('012345'), 'Invalid PIN code');
      expect(india.postalCode('110001'), null);
    });

    test('Germany postal code', () {
      expect(germany.postalCode('1234'), 'Invalid German postal code');
      expect(germany.postalCode('10115'), null);
    });

    test('Pakistan postal code', () {
      expect(pakistan.postalCode('123'), 'Invalid Pakistani postal code');
      expect(pakistan.postalCode('44000'), null);
    });

    test('Generic country', () {
      expect(generic.postalCode(''), 'Postal code is required');
      expect(generic.postalCode('12'), 'Enter a valid postal code');
      expect(generic.postalCode('12345'), null);

      expect(generic.stateOrProvince(''), 'State / Province is required');
      expect(generic.stateOrProvince('A'), 'Enter a valid state or province');
      expect(generic.stateOrProvince('SomeState'), null);
    });

    test('CountryRules.of lookup', () {
      expect(CountryRules.of('CA'), isA<CanadaRules>());
      expect(CountryRules.of('us'), isA<USRules>());
      expect(CountryRules.of('GB'), isA<UKRules>());
      expect(CountryRules.of('UK'), isA<UKRules>());
      expect(CountryRules.of('AU'), isA<AustraliaRules>());
      expect(CountryRules.of('IN'), isA<IndiaRules>());
      expect(CountryRules.of('DE'), isA<GermanyRules>());
      expect(CountryRules.of('PK'), isA<PakistanRules>());
      expect(CountryRules.of('FR'), isA<GenericCountryRules>());
    });
  });
}
