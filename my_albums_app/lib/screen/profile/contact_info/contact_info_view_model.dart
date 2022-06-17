import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as coordinates;
import 'package:my_albums_app/screen/profile/contact_info/validator.dart';
import 'package:rxdart/rxdart.dart';

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

class MyField {
  late String title;
  FieldKeys? key;
  final TextEditingController controller = TextEditingController();
  ValidationError error = ValidationError.none;
  final TextInputType? textInputType;
  late final FocusNode? focusNode;
  FocusNode? toFocus;

  MyField(
      {this.textInputType,
      this.toFocus,
      this.focusNode,
      String? initialValue,
      this.key}) {
    if (initialValue != null) {
      controller.text = initialValue;
    }
  }

  String get getText {
    return controller.text;
  }

  void setText(String text) {
    controller.text = text;
  }
}

class Input {
  final Subject<Map<FieldKeys, MyField>> applyChanges = PublishSubject();
  final Subject<bool> fetchLocation = PublishSubject();
}

class Output {
  final Stream<bool> changesApplied;
  final Stream<Placemark> fetchedLocation;
  ///final Stream<bool> changesSucceeded;

  Output({
    required this.changesApplied,
    required this.fetchedLocation,
  }); ///required this.changesSucceeded});
}

class ContactInfoViewModel {
  final ProfileRepo _profileRepo;
  late final Input input;
  late final Output output;

  ContactInfoViewModel(this._profileRepo, this.input) {
    final stream = input.applyChanges.flatMap((field) => _applyChanges(field));
    output = Output(
      changesApplied: stream,
      fetchedLocation: input.fetchLocation.flatMap((_) => _getCurrentLocationAddress()),
      /// changesSucceeded: stream,
    );
  }

  Stream<Placemark> _getCurrentLocationAddress() {
    coordinates.Location location = coordinates.Location();
    return location.getLocation().then((data) {
      return placemarkFromCoordinates(data.latitude!, data.longitude!)
          .then((placeMarks) {
        return placeMarks[0];
      });
    }).asStream();
  }

  Stream<bool> _applyChanges(Map<FieldKeys, MyField> fields) {
    print('applying!'); //TODO figure out why this is called twice
    if (!_validateForm(fields)) return Stream.value(false);
    return _profileRepo
        .saveProfile(Profile(
            firstName: fields[FieldKeys.firstName]!.getText,
            lastName: fields[FieldKeys.lastName]!.getText,
            email: fields[FieldKeys.email]!.getText,
            phone: fields[FieldKeys.phone]!.getText,
            year: DateTime.now().year,
            address: Address(
              street: fields[FieldKeys.street]!.getText,
              country: fields[FieldKeys.country]!.getText,
              city: fields[FieldKeys.city]!.getText,
              zipCode: fields[FieldKeys.zipCode]!.getText,
            )))
        .asStream();
  }

  bool _validateForm(Map<FieldKeys, MyField> fields) {
    var result = true;
    FormValidator.validateField(fields[FieldKeys.firstName]!);
    FormValidator.validateField(fields[FieldKeys.lastName]!);
    FormValidator.validateField(fields[FieldKeys.email]!);
    FormValidator.validateField(fields[FieldKeys.phone]!);
    FormValidator.validateField(fields[FieldKeys.street]!);
    FormValidator.validateField(fields[FieldKeys.city]!);
    FormValidator.validateField(fields[FieldKeys.country]!);
    FormValidator.validateField(fields[FieldKeys.zipCode]!);
    fields.forEach((key, value) {
      if (value.error != ValidationError.none) result = false;
    });
    return result;
  }
}
