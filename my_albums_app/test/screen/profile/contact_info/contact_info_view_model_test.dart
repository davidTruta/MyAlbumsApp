import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_albums_app/model/address.dart';
import 'package:my_albums_app/model/profile.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';
import 'package:my_albums_app/screen/profile/contact_info/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("contact_info_view_model - ", () {
    final mockProfileValues = Profile(
      firstName: 'first',
      lastName: 'last',
      email: 'email@gmail.com',
      phone: '0712345678',
      address: Address(
          street: '1600 Amphitheatre Pkwy',
          city: 'Mountain View',
          country: 'United States',
          zipCode: '94043'),
    );
    Profile mockProfile = mockProfileValues;
    late Map<FieldKeys, MyField> mockFields;
    ProfileRepo? profileRepo;
    ContactInfoViewModel? contactInfoViewModel;
    final placeValues = Placemark(
        street: mockProfile.address!.street,
        postalCode: mockProfile.address!.zipCode,
        locality: mockProfile.address!.city,
        country: mockProfile.address!.country);
    Placemark mockPlace = placeValues;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      profileRepo = ProfileRepo(SharedPreferences.getInstance());
      contactInfoViewModel = ContactInfoViewModel(profileRepo!, Input());
      mockProfile = mockProfileValues;
      mockFields = {
        FieldKeys.firstName: MyField(
            key: FieldKeys.firstName,
            initialValue: mockProfile.firstName,
            textInputType: TextInputType.name),
        FieldKeys.lastName: MyField(
            key: FieldKeys.lastName,
            initialValue: mockProfile.lastName,
            textInputType: TextInputType.name),
        FieldKeys.email: MyField(
            key: FieldKeys.email,
            initialValue: mockProfile.email,
            textInputType: TextInputType.emailAddress),
        FieldKeys.phone: MyField(
            key: FieldKeys.phone,
            initialValue: mockProfile.phone,
            textInputType: TextInputType.phone),
        FieldKeys.street: MyField(
            key: FieldKeys.street,
            initialValue: mockProfile.address!.street,
            textInputType: TextInputType.streetAddress),
        FieldKeys.zipCode: MyField(
            key: FieldKeys.zipCode,
            initialValue: mockProfile.address!.zipCode,
            textInputType: TextInputType.number),
        FieldKeys.city:
        MyField(key: FieldKeys.city, initialValue: mockProfile.address!.city),
        FieldKeys.country: MyField(
          key: FieldKeys.country,
          initialValue: mockProfile.address!.country,
        )
      };
      mockPlace = placeValues;
    });

    test(
        'setLocationFields() - should reset errors and set text to fetched place',
        () {
      contactInfoViewModel!.setLocationFields(mockFields, mockPlace);

      expect(
          mockFields[FieldKeys.street]!.getText, mockProfile.address!.street);
      expect(
          mockFields[FieldKeys.zipCode]!.getText, mockProfile.address!.zipCode);
      expect(mockFields[FieldKeys.city]!.getText, mockProfile.address!.city);
      expect(
          mockFields[FieldKeys.country]!.getText, mockProfile.address!.country);
      expect(mockFields[FieldKeys.country]!.error, ValidationError.none);
      expect(mockFields[FieldKeys.zipCode]!.error, ValidationError.none);
      expect(mockFields[FieldKeys.city]!.error, ValidationError.none);
      expect(mockFields[FieldKeys.street]!.error, ValidationError.none);
    });

    group('validator', () {
      void validateFields() {
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.firstName]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.lastName]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.email]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.phone]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.street]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.city]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.country]);
        contactInfoViewModel!.validator
            .validateField(mockFields[FieldKeys.zipCode]);
      }

      test('good data', () {
        validateFields();

        expect(mockFields[FieldKeys.firstName]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.lastName]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.email]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.phone]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.street]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.city]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.country]!.error, ValidationError.none);
        expect(mockFields[FieldKeys.zipCode]!.error, ValidationError.none);
      });

      test('bad data - empty', () {
        mockFields[FieldKeys.firstName]!.setText('');
        mockFields[FieldKeys.lastName]!.setText('');
        mockFields[FieldKeys.email]!.setText('');
        mockFields[FieldKeys.phone]!.setText('');
        mockFields[FieldKeys.street]!.setText('');
        mockFields[FieldKeys.city]!.setText('');
        mockFields[FieldKeys.country]!.setText('');
        mockFields[FieldKeys.zipCode]!.setText('');

        validateFields();

        expect(
            mockFields[FieldKeys.firstName]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.lastName]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.email]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.phone]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.street]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.city]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.country]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.zipCode]!.error, ValidationError.required);
      });

      test('bad data - invalid', () {
        mockFields[FieldKeys.firstName]!.setText('effective2');
        mockFields[FieldKeys.lastName]!.setText('Agent007');
        mockFields[FieldKeys.email]!.setText('mailInvalid');
        mockFields[FieldKeys.phone]!.setText('07words');
        mockFields[FieldKeys.street]!.setText('');
        mockFields[FieldKeys.city]!.setText('C1t9');
        mockFields[FieldKeys.country]!.setText('Co4ntr9');
        mockFields[FieldKeys.zipCode]!.setText('i2e45');

        validateFields();

        expect(mockFields[FieldKeys.firstName]!.error,
            ValidationError.lettersOnly);
        expect(
            mockFields[FieldKeys.lastName]!.error, ValidationError.lettersOnly);
        expect(
            mockFields[FieldKeys.email]!.error, ValidationError.invalidEmail);
        expect(mockFields[FieldKeys.phone]!.error, ValidationError.digitsOnly);
        expect(mockFields[FieldKeys.street]!.error, ValidationError.required);
        expect(mockFields[FieldKeys.city]!.error, ValidationError.lettersOnly);
        expect(
            mockFields[FieldKeys.country]!.error, ValidationError.lettersOnly);
        expect(
            mockFields[FieldKeys.zipCode]!.error, ValidationError.digitsOnly);
      });
    });

    group('changesApplied - applyChanges', () {
      test('emits true for valid fields', () {
        expect(contactInfoViewModel!.output.changesApplied, emits(true));
        contactInfoViewModel!.input.applyChanges.add(mockFields);
      });

      test('emits false for invalid fields', () {
        mockFields[FieldKeys.email]!.setText('invalid');
        expect(contactInfoViewModel!.output.changesApplied, emits(false));
        contactInfoViewModel!.input.applyChanges.add(mockFields);
      });
    });

/*    group('fetchedLocation - fetchLocation', () {
      test('emits a placeMark for every input', () {
        expect(contactInfoViewModel!.output.fetchedLocation,
            emitsInOrder([mockPlace]));
        contactInfoViewModel!.input.fetchLocation.add(true);
      });// TODO don't know how to test this
    });*/

    group('changesSucceeded - applyChanges', () {
      test('emits true for valid fields', () {
        expect(contactInfoViewModel!.output.changesSucceeded, emits(true));
        contactInfoViewModel!.input.applyChanges.add(mockFields);
      });

      test('emits false for invalid fields', () {
        expect(contactInfoViewModel!.output.changesSucceeded, emits(false));
        mockFields[FieldKeys.email]!.setText('invalid');
        contactInfoViewModel!.input.applyChanges.add(mockFields);
      });
    });
  });
}
