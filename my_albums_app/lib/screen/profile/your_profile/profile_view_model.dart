import 'dart:async';

import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../model/profile.dart';

enum ProfileState { unknown, user }

class ProfileStateData {
  final ProfileState profileState;
  final Profile? profile;

  ProfileStateData(this.profileState, [this.profile]);
}

class Input {
  final Subject<bool> load = BehaviorSubject();
}

class Output {
  final Stream<ProfileStateData> data;

  Output(this.data);
}

class ProfileViewModel {
  final ProfileRepo _profileRepo;
  late final Input input;
  late final Output output;

  ProfileViewModel(this._profileRepo, this.input) {
    output = Output(
      input.load.flatMap((_) => _profileRepo.getProfile().asStream().map(
            (profile) => profile == null
                ? ProfileStateData(ProfileState.unknown)
                : ProfileStateData(ProfileState.user, profile),
          )),
    );
  }
}
