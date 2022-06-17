import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';
import 'package:my_albums_app/screen/profile/contact_info/validator.dart';
import 'package:my_albums_app/screen/profile/contact_info/widgets/text_field_widget.dart';

import '../../../../theming/dimensions.dart';

class FormWidget extends StatelessWidget {
  ContactInfoViewModel contactInfoViewModel;
  final Map<FieldKeys, MyField> fields;

  FormWidget(
      {Key? key, required this.fields, required this.contactInfoViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: leftFormFieldPadding,
                  child: TextFieldWidget.fromField(
                    field: fields[FieldKeys.firstName]!,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: rightFormFieldPadding,
                  child: TextFieldWidget.fromField(
                    field: fields[FieldKeys.lastName]!,
                  ),
                ),
              )
            ],
          ),
          smallVerticalDistance,
          TextFieldWidget.fromField(
            field: fields[FieldKeys.email]!,
          ),
          smallVerticalDistance,
          TextFieldWidget.fromField(
            field: fields[FieldKeys.phone]!,
          ),
          xxxLargeVerticalDistance,
          StreamBuilder(
            stream: contactInfoViewModel.output.fetchedLocation,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final place = snapshot.data as Placemark;
                fields[FieldKeys.street]!.error = ValidationError.none;
                fields[FieldKeys.city]!.error = ValidationError.none;
                fields[FieldKeys.country]!.error = ValidationError.none;
                fields[FieldKeys.zipCode]!.error = ValidationError.none;
                fields[FieldKeys.street]!.setText(place.street!);
                fields[FieldKeys.city]!.setText(place.locality!);
                fields[FieldKeys.country]!.setText(place.country!);
                fields[FieldKeys.zipCode]!.setText(place.postalCode!);
              }
              return Column(
                  children: [
                    TextFieldWidget.fromField(
                      field: fields[FieldKeys.street]!,
                    ),
                    smallVerticalDistance,
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: leftFormFieldPadding,
                            child: TextFieldWidget.fromField(
                              field: fields[FieldKeys.city]!,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: rightFormFieldPadding,
                            child: TextFieldWidget.fromField(
                              field: fields[FieldKeys.country]!,
                            ),
                          ),
                        ),
                      ],
                    ),
                    smallVerticalDistance,
                    TextFieldWidget.fromField(
                      field: fields[FieldKeys.zipCode]!,
                    ),
                  ],
                );

            },
          ),
        ],
      ),
    );
  }
}
