import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/profile.dart';
import '../../../theming/dimensions.dart';
import 'widgets/form_widget.dart';

class ContactInfoScreen extends StatefulWidget {
  final Profile? profile;

  const ContactInfoScreen({Key? key, this.profile}) : super(key: key);

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  ContactInfoViewModel contactInfoViewModel = ContactInfoViewModel(
      ProfileRepo(SharedPreferences.getInstance()), Input());
  late Map<FieldKeys, MyField> _fields;

  @override
  initState() {
    _fields = {
      FieldKeys.firstName: MyField(
          focusNode: FocusNode(), initialValue: widget.profile?.firstName),
      FieldKeys.lastName: MyField(
          focusNode: FocusNode(), initialValue: widget.profile?.lastName),
      FieldKeys.email:
          MyField(focusNode: FocusNode(), initialValue: widget.profile?.email),
      FieldKeys.phone:
          MyField(focusNode: FocusNode(), initialValue: widget.profile?.phone),
      FieldKeys.street: MyField(
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.street),
      FieldKeys.city: MyField(
          focusNode: FocusNode(), initialValue: widget.profile?.address?.city),
      FieldKeys.country: MyField(
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.country),
      FieldKeys.zipCode: MyField(
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.zipCode),
    };
    super.initState();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBarWidget(
      title: Text(AppLocalizations.of(context)!.contactInfo,
          style: Theme.of(context).textTheme.headlineSmall),
      automaticallyImplyLeading: false,
      leading: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppLocalizations.of(context)!.back),
      ),
      actions: [
        StreamBuilder(
            stream: contactInfoViewModel.output.applyChangesData,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Navigator.of(context).pop(),
                );
              }
              return TextButton(
                onPressed: () {
                  contactInfoViewModel.input.load.add(_fields);
                },
                child: Text(AppLocalizations.of(context)!.apply),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: albumListPadding,
        children: [
          normalVerticalDistance,
          StreamBuilder(
              stream: contactInfoViewModel.output.applyChangesData,
              builder: (context, snapshot) {
                return FormWidget(
                  fields: _fields,
                );
              }),
          largeVerticalDistance,
          Align(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                visualDensity: VisualDensity.compact),
            onPressed: () {
              setState(() {
                contactInfoViewModel.getCurrentLocationAddress().then((place) {
                  /* _fields['street']!['validationError'] = '';
                  _fields['city']!['validationError'] = '';
                  _fields['country']!['validationError'] = '';
                  _fields['zipCode']!['validationError'] = '';

                  _fields['street']!['controller'].text = place.street;
                  _fields['city']!['controller'].text = place.locality;
                  _fields['country']!['controller'].text = place.country;
                  _fields['zipCode']!['controller'].text = place.postalCode;*/
                });
              });
            },
            child: Text(
              AppLocalizations.of(context)!.useMyLocation,
            ),
          )),
        ],
      ),
    );
  }
}
