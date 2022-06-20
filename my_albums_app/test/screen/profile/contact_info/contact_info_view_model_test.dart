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
    ProfileRepo? profileRepo;
    ContactInfoViewModel? contactInfoViewModel;
    Profile? mockProfile = Profile(
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
    Placemark mockPlace = Placemark(
        street: mockProfile.address!.street,
        postalCode: mockProfile.address!.zipCode,
        locality: mockProfile.address!.city,
        country: mockProfile.address!.country);
    Map<FieldKeys, MyField> mockFields = {
      FieldKeys.firstName: MyField(
          key: FieldKeys.firstName,
          initialValue: mockProfile.firstName,
          textInputType: TextInputType.name),
      FieldKeys.street: MyField(
          key: FieldKeys.street,
          initialValue: 'init',
          textInputType: TextInputType.name),
      FieldKeys.zipCode: MyField(
          key: FieldKeys.zipCode,
          initialValue: 'init',
          textInputType: TextInputType.name),
      FieldKeys.city: MyField(
          key: FieldKeys.city,
          initialValue: 'init',
          textInputType: TextInputType.name),
      FieldKeys.country: MyField(
          key: FieldKeys.country,
          initialValue: 'init',
          textInputType: TextInputType.name)
    };

    //This will run before every test
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      profileRepo = ProfileRepo(SharedPreferences.getInstance());
      contactInfoViewModel = ContactInfoViewModel(profileRepo!, Input());
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
      test('good data', () {
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
      });

      test('bad data - empty', () {
        //TODO
      });

      test('bad data - invalid', () {
        //TODO
      });
    });

    group('changesApplied', () {
      test('emits last result when a new stream is added to applyChanges', () {
        //TODO
      });
    });

    group('fetchedLocation', () {
      test('', () {
        //TODO
      });
    });

    group('changesSucceeded', () {
      test('', () {
        //TODO
      });
    });
  });
}
