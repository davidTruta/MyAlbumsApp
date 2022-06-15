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

  void _validateField(String key, String val, RegExp regExp, String msg,
      Map<String, String> res) {
    if (val.isEmpty) {
      res.putIfAbsent(key, () => 'required');
    } else if (!val.contains(regExp)) {
      res.putIfAbsent(key, () => msg);
    } else {
      res.putIfAbsent(key, () => '');
    }
  }

  Map<String, String> validateForm(Map<String, String> values) {
    Map<String, String> result = {};

    final letOnlyRegEx = RegExp(r'^[a-z ]+$', caseSensitive: false);
    _validateField('firstName', values['firstName']!, letOnlyRegEx,
        'letters only', result);
    _validateField(
        'lastName', values['lastName']!, letOnlyRegEx, 'letters only', result);
    _validateField(
        'city', values['city']!, letOnlyRegEx, 'letters only', result);
    _validateField(
        'country', values['country']!, letOnlyRegEx, 'letters only', result);

    final digOnlyRegEx = RegExp(r'^[0-9]+$');
    _validateField(
        'phone', values['phone']!, digOnlyRegEx, 'digits only', result);
    _validateField(
        'zipCode', values['zipCode']!, digOnlyRegEx, 'digits only', result);

    _validateField(
        'street', values['street']!, RegExp(r'.*'), 'invalid street', result);

    _validateField('email', values['email']!,
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'), 'invalid email', result);

    return result;
  }
}
