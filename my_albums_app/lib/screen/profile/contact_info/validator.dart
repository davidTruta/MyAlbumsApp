import 'package:my_albums_app/utils.dart';

import 'contact_info_view_model.dart';

enum ValidationError{
  none,
  required,
  lettersOnly,
  digitsOnly,
  invalidEmail,
  invalidStreet
}


class FormValidator {
  static final FormValidator _singleton = FormValidator._internal();

  factory FormValidator() {
    return _singleton;
  }

  FormValidator._internal();

  static void _validate(MyField field, RegExp regExp, ValidationError error) {
    if (field.getText.isEmpty) {
      field.error = ValidationError.required;
    } else if (!field.getText.contains(regExp)) {
      field.error = error;
      field.setText('');
    } else {
      field.error = ValidationError.none;
    }
  }

  static void validateField(MyField field) {
    if (field.key == FieldKeys.firstName ||
        field.key == FieldKeys.lastName ||
        field.key == FieldKeys.city ||
        field.key == FieldKeys.country) {
      _validate(field, letOnlyRegEx, ValidationError.lettersOnly);
    } else if (field.key == FieldKeys.phone || field.key == FieldKeys.zipCode) {
      _validate(field, digOnlyRegEx, ValidationError.digitsOnly);
    } else if (field.key == FieldKeys.email) {
      _validate(field, emailRegEx, ValidationError.invalidEmail);
    } else if (field.key == FieldKeys.street) {
      _validate(field, streetRegEx, ValidationError.invalidStreet);
    }
  }
}
