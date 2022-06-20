
import 'package:flutter_test/flutter_test.dart';
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

    test('getProfile() test case: should fetch profile from local storage', () async {

    });

    test('setAlbums() test case: should save profile to local storage', () async {

    });

  });
}
