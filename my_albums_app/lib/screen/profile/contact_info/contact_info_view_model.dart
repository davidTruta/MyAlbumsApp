import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as coordinates;
import 'package:rxdart/rxdart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/address.dart';
import '../../../model/profile.dart';
import '../../../repo/profile_repo.dart';

enum FieldKeys {
  firstName,
  lastName,
  email,
  phone,
  street,
  city,
  country,
  zipCode,
}

class MyString {
  String value = '';
}

class MyField {
  final TextEditingController controller = TextEditingController();
  late final MyString validationError;
  final FocusNode focusNode;

  MyField({required this.focusNode, String? initialValue}) {
    validationError = MyString();
    if (initialValue != null) {
      controller.text = initialValue;
    }
  }
}

class Input {
  final Subject<Map<FieldKeys, MyField>> load = BehaviorSubject();
}

class Output {
  final Stream<bool> applyChangesData;

  Output({required this.applyChangesData});
}

class ContactInfoViewModel {
  final ProfileRepo _profileRepo;
  late final Input input;
  late final Output output;

  ContactInfoViewModel(this._profileRepo, this.input) {
    output = Output(
      applyChangesData: input.load.flatMap((field) => applyChanges(field)),
    );
  }

  Future<Placemark> getCurrentLocationAddress() {
    coordinates.Location location = coordinates.Location();
    return location.getLocation().then((data) {
      return placemarkFromCoordinates(data.latitude!, data.longitude!)
          .then((placeMarks) {
        return placeMarks[0];
      });
    });
  }

  Stream<bool> applyChanges(Map<FieldKeys, MyField> fields) {
    if (!validateForm(fields)) return Future(() => false).asStream();//TODO is this ok?
    return _profileRepo
        .saveProfile(Profile(
            id: 1,
            firstName: fields[FieldKeys.firstName]!.controller.text,
            lastName: fields[FieldKeys.lastName]!.controller.text,
            email: fields[FieldKeys.email]!.controller.text,
            phone: fields[FieldKeys.phone]!.controller.text,
            address: Address(
              id: 1,
              street: fields[FieldKeys.street]!.controller.text,
              country: fields[FieldKeys.country]!.controller.text,
              city: fields[FieldKeys.city]!.controller.text,
              zipCode: fields[FieldKeys.zipCode]!.controller.text,
            )))
        .asStream();
  }

  void _validateField(MyField field, RegExp validationRegExp, String errorMsg) {
    if (field.controller.text.isEmpty) {
      field.validationError.value = 'required';
    } else if (!field.controller.text.contains(validationRegExp)) {
      field.validationError.value = errorMsg;
      field.controller.text = '';
    } else {
      field.validationError.value = '';
    }
  }

  bool validateForm(Map<FieldKeys, MyField> fields) {
    var result = true;
    final letOnlyRegEx = RegExp(r'^[a-z ]+$', caseSensitive: false);
    final digOnlyRegEx = RegExp(r'^[0-9]+$');
    final streetRegEx = RegExp(r'.*');
    final emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    _validateField(fields[FieldKeys.firstName]!, letOnlyRegEx, 'letters only');
    _validateField(fields[FieldKeys.lastName]!, letOnlyRegEx, 'letters only');
    _validateField(fields[FieldKeys.email]!, emailRegEx, 'invalid email');
    _validateField(fields[FieldKeys.phone]!, digOnlyRegEx, 'digits only');
    _validateField(fields[FieldKeys.street]!, streetRegEx, 'invalid street');
    _validateField(fields[FieldKeys.city]!, letOnlyRegEx, 'letters only');
    _validateField(fields[FieldKeys.country]!, letOnlyRegEx, 'letters only');
    _validateField(fields[FieldKeys.zipCode]!, digOnlyRegEx, 'digits only');
    fields.forEach((key, value) {
      if (value.validationError.value != '') result = false;
    });
    return result;
  }
}
