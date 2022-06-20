import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/model/address.dart';
import 'package:my_albums_app/model/profile.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/your_profile/profile_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group("profile_view_model - ", () {
    ProfileRepo? profileRepo;
    ProfileViewModel? profileViewModel;
    Profile? mockProfile = Profile(
      firstName: 'first',
      lastName: 'last',
      email: 'email@gmail.com',
      phone: '0712345678',
      address:
          Address(street: 'str', city: 'cit', country: 'cou', zipCode: '123'),
    );

    //This will run before every test
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      profileRepo = ProfileRepo(SharedPreferences.getInstance());
      profileViewModel = ProfileViewModel(profileRepo!, Input());
    });

    test('should always emit the last ProfileData', () {
      profileRepo!.saveProfile(mockProfile);
      profileViewModel!.input.load.add(true);

      profileViewModel!.input.load.add(true);

      expect(
          profileViewModel!.output.data,
          emitsInOrder([
            ProfileData(profile: mockProfile),
            ProfileData(profile: mockProfile),
          ]));

      profileViewModel!.input.load.add(true);
    });

    test('emits the correct ProfileData - profile is null', () {
      // no Profile is currently saved
      profileViewModel!.input.load.add(true);
      profileViewModel!.output.data.listen(
        (profileData) {
          expect(profileData.profile, null);
          expect(profileData.memberSince, "");
          expect(profileData.emailAddress, "");
          expect(profileData.fullName, "unknown");
          expect(profileData.circularAvatarText, "?");
        },
      );
    });

    test('emits the correct ProfileData - profile is not null', () {
      profileRepo!.saveProfile(mockProfile);
      profileViewModel!.input.load.add(true);
      profileViewModel!.output.data.listen(
            (profileData) {
          expect(profileData.profile, mockProfile);
          expect(profileData.memberSince, "memberSince");
          expect(profileData.emailAddress, "emailAddress");
          expect(profileData.fullName, "first last");
          expect(profileData.circularAvatarText, "f");
        },
      );
    });
  });
}
