import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_albums_app/model/address.dart';
import 'package:my_albums_app/model/profile.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("profile_repo - ", () {
    ProfileRepo? profileRepo;
    Profile? mockProfile;

    //This will run before every test
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      profileRepo = ProfileRepo(SharedPreferences.getInstance());
      SharedPreferences.setMockInitialValues({});
      mockProfile = Profile(
        firstName: 'first',
        lastName: 'last',
        email: 'email@gmail.com',
        phone: '0712345678',
        address: Address(
          street: 'str',
          city: 'cit',
          country: 'cou',
          zipCode: '123'
        )
      );
    });

    test('setProfile() test case: should save profile to local storage', () async {
      final response = await profileRepo!.saveProfile(mockProfile!);

      expect(response, true);
    });

    test('getProfile() test case: should fetch profile from local storage', () async {
      final response = await profileRepo!.saveProfile(mockProfile!);
      expect(response, true);

      final profile = await profileRepo!.getProfile();
      expect(profile, mockProfile);
    });

    test('getProfile() test case: should fetch NULL from local storage, there is no profile', () async {
      final profile = await profileRepo!.getProfile();
      expect(profile, null);
    });

    test('getCurrentLocation() test case : should fetch the current location', () async {
      final place = await profileRepo!.getCurrentLocationAddress();
      //TODO can I test this?
    });

  });
}
