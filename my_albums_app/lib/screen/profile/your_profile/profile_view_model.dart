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

class Input {
  late final ProfileRepo _profileRepo;
  late final Sink<Future<Profile?>> _sink;

  Input(Sink<Future<Profile?>> profile, ProfileRepo repo) {
    _profileRepo = repo;
    _sink = profile;
  }

  void load() {
    _sink.add(_profileRepo.getProfile());
  }
}

class Output {
  late final Stream<Future<Profile?>> _stream;

  Output(Stream<Future<Profile?>> stream) {
    _stream = stream;
  }

  Stream<ProfileStateData> get getProfileStateData {
    return _stream.asyncMap((profileFuture) {
      return profileFuture.then((profile) {
        return profile == null
            ? ProfileStateData(ProfileState.unknown)
            : ProfileStateData(ProfileState.user, profile);
      });
    });
  }
}

class ProfileViewModel {
  final ProfileRepo _profileRepo;
  late final Input input;
  late final Output output;
  final Subject<Future<Profile?>> _controller = BehaviorSubject();

  ProfileViewModel(this._profileRepo) {
    input = Input(_controller.sink, _profileRepo);
    output = Output(_controller.stream);
  }

  void dispose() {
    _controller.close();
  }
}
