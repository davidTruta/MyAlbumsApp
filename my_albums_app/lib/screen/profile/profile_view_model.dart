import 'package:my_albums_app/repo/profile_repo.dart';

import '../../model/profile.dart';

class ProfileViewModel {
  final ProfileRepo _profileRepo;

  ProfileViewModel(this._profileRepo);

  Future<Profile> getProfile() async {
    return await _profileRepo.getProfile();
  }

  Future<void> saveProfile(Profile profile) async {
    return await _profileRepo.saveProfile(profile);
  }
}
