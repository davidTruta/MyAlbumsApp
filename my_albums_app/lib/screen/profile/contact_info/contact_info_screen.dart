import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:my_albums_app/widgets/app_bar_widget.dart';

import '../../../model/address.dart';
import '../../../model/profile.dart';
import '../../../theming/dimensions.dart';
import '../profile_view_model.dart';

class ContactInfoScreen extends StatefulWidget {
  final ProfileViewModel profileViewModel;
  final Function updateProfile;

  const ContactInfoScreen(
      {Key? key, required this.profileViewModel, required this.updateProfile})
      : super(key: key);

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late final FocusNode fnFirstLast;
  late final FocusNode fnLastEmail;
  late final FocusNode fnEmailPhone;

  late final FocusNode fnStreetCity;
  late final FocusNode fnCityCountry;
  late final FocusNode fnCountryZip;

  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? street;
  String? city;
  String? country;
  String? zipCode;

  bool isLoading = false;

  @override
  initState() {
    super.initState();
    fnCityCountry = FocusNode();
    fnCountryZip = FocusNode();
    fnEmailPhone = FocusNode();
    fnFirstLast = FocusNode();
    fnLastEmail = FocusNode();
    fnStreetCity = FocusNode();
  }

  @override
  dispose() {
    fnStreetCity.dispose();
    fnLastEmail.dispose();
    fnFirstLast.dispose();
    fnEmailPhone.dispose();
    fnCountryZip.dispose();
    fnCityCountry.dispose();
    super.dispose();
  }

  InputDecoration _getInputDecoration([String? title]) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      label: title != null
          ? Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            )
          : null,
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).errorColor, width: 2.0),
      ),
      errorText: null,
      errorMaxLines: 1,
      errorStyle: const TextStyle(
        color: Colors.transparent,
        fontSize: 0,
      ),
    );
  }

  Future<bool> applyChanges() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();

    setState(() {
      isLoading = true;
    });

    await widget.profileViewModel.saveProfile(Profile(
      id: 1,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      address: Address(
          id: 1,
          street: street,
          country: country,
          city: city,
          zipCode: zipCode),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: albumListPadding,
          children: [
            largeVerticalDistance,
            Row(
              children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.labelSmall,
                    decoration: _getInputDecoration(
                        AppLocalizations.of(context)!.firstName.toUpperCase()),
                    onFieldSubmitted: (str) {
                      fnFirstLast.requestFocus();
                    },
                    onSaved: (str) {
                      firstName = str;
                    },
                    validator: (str) {
                      if (str!.isEmpty) {
                        return 'First name field cannot be empty';
                      }
                      return null;
                    },
                  ),
                )),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.labelSmall,
                    decoration: _getInputDecoration(
                        AppLocalizations.of(context)!.lastName.toUpperCase()),
                    focusNode: fnFirstLast,
                    onFieldSubmitted: (str) {
                      fnLastEmail.requestFocus();
                    },
                    onSaved: (str) {
                      lastName = str;
                    },
                    validator: (str) {
                      print('validation');
                      if (str!.isEmpty) {
                        return 'Last name field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ))
              ],
            ),
            smallVerticalDistance,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: Theme.of(context).textTheme.labelSmall,
              decoration: _getInputDecoration(
                  AppLocalizations.of(context)!.emailAddress.toUpperCase()),
              focusNode: fnLastEmail,
              onFieldSubmitted: (str) {
                fnEmailPhone.requestFocus();
              },
              onSaved: (str) {
                email = str;
              },
              validator: (str) {
                print('validation');
                if (str!.isEmpty) {
                  return 'First name field cannot be empty';
                }
                return null;
              },
            ),
            smallVerticalDistance,
            TextFormField(
              keyboardType: TextInputType.phone,
              style: Theme.of(context).textTheme.labelSmall,
              decoration: _getInputDecoration(
                  AppLocalizations.of(context)!.phoneNumber.toUpperCase()),
              focusNode: fnEmailPhone,
              onSaved: (str) {
                phone = str;
              },
              validator: (str) {
                print('validation');
                if (str!.isEmpty) {
                  return 'First name field cannot be empty';
                }
                return null;
              },
            ),
            xxxLargeVerticalDistance,
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              style: Theme.of(context).textTheme.labelSmall,
              decoration: _getInputDecoration(
                  AppLocalizations.of(context)!.streetAddress.toUpperCase()),
              onFieldSubmitted: (str) {
                fnStreetCity.requestFocus();
              },
              onSaved: (str) {
                street = str;
              },
              validator: (str) {
                print('validation');
                if (str!.isEmpty) {
                  return 'First name field cannot be empty';
                }
                return null;
              },
            ),
            smallVerticalDistance,
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.labelSmall,
                      decoration: _getInputDecoration(
                          AppLocalizations.of(context)!.city.toUpperCase()),
                      focusNode: fnStreetCity,
                      onFieldSubmitted: (str) {
                        fnCityCountry.requestFocus();
                      },
                      onSaved: (str) {
                        city = str;
                      },
                      validator: (str) {
                        print('validation');
                        if (str!.isEmpty) {
                          return 'First name field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.labelSmall,
                      decoration: _getInputDecoration(
                          AppLocalizations.of(context)!.country.toUpperCase()),
                      focusNode: fnCityCountry,
                      onFieldSubmitted: (str) {
                        fnCountryZip.requestFocus();
                      },
                      onSaved: (str) {
                        country = str;
                      },
                      validator: (str) {
                        print('validation');
                        if (str!.isEmpty) {
                          return 'First name field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                )
              ],
            ),
            smallVerticalDistance,
            TextFormField(
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.labelSmall,
              decoration: _getInputDecoration(
                  AppLocalizations.of(context)!.zipCode.toUpperCase()),
              focusNode: fnCountryZip,
              onSaved: (str) {
                zipCode = str;
              },
              validator: (str) {
                print('validation');
                if (str!.isEmpty) {
                  return 'First name field cannot be empty';
                }
                return null;
              },
            ),
            largeVerticalDistance,
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                //TODO
              },
              child: Text(
                AppLocalizations.of(context)!.useMyLocation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
