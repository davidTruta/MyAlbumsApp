import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as coordinates;
import 'package:my_albums_app/widgets/app_bar_widget.dart';

import '../../../model/address.dart';
import '../../../model/profile.dart';
import '../../../theming/dimensions.dart';
import '../profile_view_model.dart';
import 'widgets/form_widget.dart';

class ContactInfoScreen extends StatefulWidget {
  final Profile? profile;
  final ProfileViewModel profileViewModel;
  final Function updateProfile;

  const ContactInfoScreen(
      {Key? key,
      required this.profileViewModel,
      required this.updateProfile,
      this.profile})
      : super(key: key);

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  bool isLoading = false;
  late final Map<String, Map<String, dynamic>> _fields;

  @override
  initState() {
    super.initState();
    _fields = {
      'firstName': {
        'controller': TextEditingController()
          ..text = widget.profile == null ? '' : widget.profile!.firstName!,
        'validationError': '',
      },
      'lastName': {
        'controller': TextEditingController()
          ..text = widget.profile == null ? '' : widget.profile!.lastName!,
        'validationError': '',
      },
      'email': {
        'controller': TextEditingController()
          ..text = widget.profile == null ? '' : widget.profile!.email!,
        'validationError': '',
      },
      'phone': {
        'controller': TextEditingController()
          ..text = widget.profile == null ? '' : widget.profile!.phone!,
        'validationError': '',
      },
      'street': {
        'controller': TextEditingController()
          ..text =
              widget.profile == null ? '' : widget.profile!.address!.street!,
        'validationError': '',
      },
      'city': {
        'controller': TextEditingController()
          ..text = widget.profile == null ? '' : widget.profile!.address!.city!,
        'validationError': '',
      },
      'country': {
        'controller': TextEditingController()
          ..text =
              widget.profile == null ? '' : widget.profile!.address!.country!,
        'validationError': '',
      },
      'zipCode': {
        'controller': TextEditingController()
          ..text =
              widget.profile == null ? '' : widget.profile!.address!.zipCode!,
        'validationError': '',
      },
    };
    _fields.forEach((key, value) {
      _fields[key]!.putIfAbsent('focusNode', () => FocusNode());
    });
  }

  @override
  dispose() {
    _fields.forEach((key, value) {
      _fields[key]!['focusNode'].dispose();
    });
    super.dispose();
  }

  Future<bool> applyChanges() async {
    bool valid = true;
    setState(() {
      widget.profileViewModel
          .validateForm(_fields
              .map((key, value) => MapEntry(key, value['controller'].text)))
          .forEach((key, value) {
        if (value != '') {
          valid = false;
          _fields[key]!['validationError'] = value;
          _fields[key]!['controller'].clear();
        }
      });
    });
    if (!valid) return valid;
    setState(() {
      isLoading = true;
    });
    await widget.profileViewModel.saveProfile(Profile(
      id: 1,
      firstName: _fields['firstName']!['controller'].text,
      lastName: _fields['lastName']!['controller'].text,
      email: _fields['email']!['controller'].text,
      phone: _fields['phone']!['controller'].text,
      address: Address(
          id: 1,
          street: _fields['street']!['controller'].text,
          country: _fields['country']!['controller'].text,
          city: _fields['city']!['controller'].text,
          zipCode: _fields['zipCode']!['controller'].text),
    ));
    widget.updateProfile();
    return true;
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
        isLoading == false
            ? TextButton(
                onPressed: () async {
                  if (await applyChanges()) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(AppLocalizations.of(context)!.apply),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  Future<Placemark> getCurrentLocationAddress() async {
    coordinates.Location location = coordinates.Location();
    final data = await location.getLocation();

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(data.latitude!, data.longitude!);
    return placeMarks[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: albumListPadding,
        children: [
          normalVerticalDistance,
          FormWidget(
            fields: _fields,
          ),
          largeVerticalDistance,
          Align(
              child: FutureBuilder(
            future: getCurrentLocationAddress(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                Placemark place = snapshot.data as Placemark;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      visualDensity: VisualDensity.compact),
                  onPressed: () async {
                    setState(() {
                      _fields['street']!['validationError'] = '';
                      _fields['city']!['validationError'] = '';
                      _fields['country']!['validationError'] = '';
                      _fields['zipCode']!['validationError'] = '';

                      _fields['street']!['controller'].text = place.street;
                      _fields['city']!['controller'].text = place.locality;
                      _fields['country']!['controller'].text = place.country;
                      _fields['zipCode']!['controller'].text = place.postalCode;
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.useMyLocation,
                  ),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
