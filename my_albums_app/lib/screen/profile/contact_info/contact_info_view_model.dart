import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as coordinates;
import 'package:rxdart/rxdart.dart';

import '../../../model/profile.dart';
import '../../../repo/profile_repo.dart';




class ContactInfoViewModel {
  final ProfileRepo _profileRepo;
  final Subject<Future<Profile?>> _controller = BehaviorSubject();

  ContactInfoViewModel(this._profileRepo);

  Future<bool> saveProfile(Profile profile) {
      return _profileRepo.saveProfile(profile);
  }

  Future<Placemark> getCurrentLocationAddress() async {
    coordinates.Location location = coordinates.Location();
    return location.getLocation().then((data) {
      return placemarkFromCoordinates(data.latitude!, data.longitude!)
          .then((placeMarks) {
        return placeMarks[0];
      });
    });
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
