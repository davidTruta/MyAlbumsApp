import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';
import 'package:my_albums_app/screen/profile/contact_info/widgets/text_field_widget.dart';

import '../../../../theming/dimensions.dart';

class FormWidget extends StatelessWidget {
  final Map<FieldKeys, MyField> fields;

  const FormWidget({Key? key, required this.fields}) : super(key: key);

  TextFieldWidget _buildTextField(MyField field, String title) {
    return TextFieldWidget(
      focusNode: field.focusNode,
      validationErrors: field.validationError,
      controller: field.controller,
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                  padding: leftFormFieldPadding,
                  child: _buildTextField(fields[FieldKeys.firstName]!,
                      AppLocalizations.of(context)!.firstName.toUpperCase())),
            ),
            Flexible(
              child: Padding(
                  padding: rightFormFieldPadding,
                  child: _buildTextField(fields[FieldKeys.lastName]!,
                      AppLocalizations.of(context)!.lastName.toUpperCase())),
            )
          ],
        ),
        smallVerticalDistance,
        _buildTextField(fields[FieldKeys.email]!,
            AppLocalizations.of(context)!.emailAddress.toUpperCase()),
        smallVerticalDistance,
        _buildTextField(fields[FieldKeys.phone]!,
            AppLocalizations.of(context)!.phoneNumber.toUpperCase()),
        xxxLargeVerticalDistance,
        _buildTextField(fields[FieldKeys.street]!,
            AppLocalizations.of(context)!.streetAddress.toUpperCase()),
        smallVerticalDistance,
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: leftFormFieldPadding,
                child: _buildTextField(fields[FieldKeys.city]!,
                    AppLocalizations.of(context)!.city.toUpperCase()),
              ),
            ),
            Flexible(
              child: Padding(
                padding: rightFormFieldPadding,
                child: _buildTextField(fields[FieldKeys.country]!,
                    AppLocalizations.of(context)!.country.toUpperCase()),
              ),
            ),
          ],
        ),
        smallVerticalDistance,
        _buildTextField(fields[FieldKeys.zipCode]!,
            AppLocalizations.of(context)!.zipCode.toUpperCase()),
      ],
    );
  }
}
