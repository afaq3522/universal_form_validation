import 'package:flutter_test/flutter_test.dart';

import 'package:universal_form_validation/universal_form_validation.dart';


void main() {
  group('BasicValidators', () {
    test('Required field', () {
      // The message matches BasicValidators.required
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
      expect(BasicValidators.password('1234567'), 'Password must be at least 8 characters');
      expect(
        BasicValidators.password('Abcdef12!', requireUppercase: true, requireNumber: true, requireSpecialChar: true),
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
      expect(BasicValidators.confirmPassword('', '1234'), 'Confirm password is required');
      expect(BasicValidators.confirmPassword('123', '1234'), 'Passwords do not match');
      expect(BasicValidators.confirmPassword('1234', '1234'), null);
    });
  });

  group('TextValidators', () {
    test('Name validation', () {
      expect(TextValidators.name(''), 'Name is required');
      expect(TextValidators.name('A'), 'Name must be at least 2 characters');
      expect(TextValidators.name('Afaq'), null);
    });

    test('Text length', () {
      expect(TextValidators.length('', min: 3, max: 5, fieldName: 'TestField'), 'TestField is required');
      expect(TextValidators.length('ab', min: 3, max: 5, fieldName: 'TestField'), 'TestField must be at least 3 characters');
      expect(TextValidators.length('abcdef', min: 3, max: 5, fieldName: 'TestField'), 'TestField must not exceed 5 characters');
      expect(TextValidators.length('abc', min: 3, max: 5, fieldName: 'TestField'), null);
    });
  });

  group('NumberValidators', () {
    test('Number validation', () {
      expect(NumberValidators.number('', fieldName: 'Age'), 'Age is required');
      expect(NumberValidators.number('abc', fieldName: 'Age'), 'Age must be numeric');
      expect(NumberValidators.number('123', fieldName: 'Age'), null);
    });

    test('Phone validation', () {
      expect(NumberValidators.phone(''), 'Phone number is required');
      expect(NumberValidators.phone('abc'), 'Enter a valid phone number');
      expect(NumberValidators.phone('12345'), 'Phone number length is invalid'); // minLength default = 7
      expect(NumberValidators.phone('+1234567890'), null);
      expect(NumberValidators.phone('1234567'), null);
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

    test('Generic country', () {
      expect(generic.postalCode(''), 'Postal code is required');
      expect(generic.postalCode('12'), 'Enter a valid postal code');
      expect(generic.postalCode('12345'), null);

      expect(generic.stateOrProvince(''), 'State / Province is required');
      expect(generic.stateOrProvince('A'), 'Enter a valid state or province');
      expect(generic.stateOrProvince('SomeState'), null);
    });
  });
}
