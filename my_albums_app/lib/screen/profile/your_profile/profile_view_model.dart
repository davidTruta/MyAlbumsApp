import 'dart:async';

import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:rxdart/subjects.dart';

import '../../../model/profile.dart';

enum ProfileState { unknown, user }

class ProfileStateData {
  final ProfileState profileState;
  final Profile? profile;

  ProfileStateData(this.profileState, [this.profile]);
}

class Input {}

class Output {}

class ProfileViewModel {
  final ProfileRepo _profileRepo;

  //TODO use Input class and Output class for streams
  late final Input input;
  late final Output output;
  final Subject<Future<Profile?>> _controller = BehaviorSubject();

  ProfileViewModel(this._profileRepo);

  Stream<ProfileStateData> get getProfileStateData {
    return _controller.stream.asyncMap((profileFuture) {
      return profileFuture.then((profile) {
        return profile == null
            ? ProfileStateData(ProfileState.unknown)
            : ProfileStateData(ProfileState.user, profile);
      });
    });
  }

  void fetchProfileStateData() {
    _controller.add(_profileRepo.getProfile());
  }

  void refreshProfileStateData() {
    fetchProfileStateData();
  }
}
