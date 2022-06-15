import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/screen/profile/contact_info/widgets/text_field_widget.dart';

import '../../../../theming/dimensions.dart';

class FormWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> fields;

  const FormWidget({Key? key, required this.fields}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: leftFormFieldPadding,
                child: TextFieldWidget(
                  focusNode: fields['firstName']!['focusNode'],
                  toFocus: fields['lastName']!['focusNode'],
                  validationErrors: fields['firstName']!,
                  controller: fields['firstName']!['controller'],
                  title: AppLocalizations.of(context)!.firstName.toUpperCase(),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: rightFormFieldPadding,
                child: TextFieldWidget(
                  focusNode: fields['lastName']!['focusNode'],
                  toFocus: fields['email']!['focusNode'],
                  validationErrors: fields['lastName']!,
                  controller: fields['lastName']!['controller'],
                  title: AppLocalizations.of(context)!.lastName.toUpperCase(),
                ),
              ),
            )
          ],
        ),
        smallVerticalDistance,
        TextFieldWidget(
          focusNode: fields['email']!['focusNode'],
          toFocus: fields['phone']!['focusNode'],
          validationErrors: fields['email']!,
          controller: fields['email']!['controller'],
          title: AppLocalizations.of(context)!.emailAddress.toUpperCase(),
          textInputType: TextInputType.emailAddress,
        ),
        smallVerticalDistance,
        TextFieldWidget(
          focusNode: fields['phone']!['focusNode'],
          validationErrors: fields['phone']!,
          controller: fields['phone']!['controller'],
          title: AppLocalizations.of(context)!.phoneNumber.toUpperCase(),
          textInputType: TextInputType.phone,
        ),
        xxxLargeVerticalDistance,
        TextFieldWidget(
          focusNode: fields['street']!['focusNode'],
          toFocus: fields['city']!['focusNode'],
          validationErrors: fields['street']!,
          controller: fields['street']!['controller'],
          title: AppLocalizations.of(context)!.streetAddress.toUpperCase(),
          textInputType: TextInputType.streetAddress,
        ),
        smallVerticalDistance,
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: leftFormFieldPadding,
                child: TextFieldWidget(
                  focusNode: fields['city']!['focusNode'],
                  toFocus: fields['country']!['focusNode'],
                  validationErrors: fields['city']!,
                  controller: fields['city']!['controller'],
                  title: AppLocalizations.of(context)!.city.toUpperCase(),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: rightFormFieldPadding,
                child: TextFieldWidget(
                  focusNode: fields['country']!['focusNode'],
                  toFocus: fields['zipCode']!['focusNode'],
                  validationErrors: fields['country']!,
                  controller: fields['country']!['controller'],
                  title: AppLocalizations.of(context)!.country.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
        smallVerticalDistance,
        TextFieldWidget(
          focusNode: fields['zipCode']!['focusNode'],
          validationErrors: fields['zipCode']!,
          controller: fields['zipCode']!['controller'],
          title: AppLocalizations.of(context)!.zipCode.toUpperCase(),
          textInputType: TextInputType.number,
        ),
      ],
    );
  }
}
