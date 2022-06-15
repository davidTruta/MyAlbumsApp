import 'package:flutter/material.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_screen.dart';
import 'package:my_albums_app/screen/profile/profile_view_model.dart';
import 'package:my_albums_app/theming/dimensions.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/widgets/list_tile_widget.dart';

import '../../model/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel profileViewModel = ProfileViewModel(ProfileRepo());

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: Text(AppLocalizations.of(context)!.yourProfile,
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ]),
      body: FutureBuilder(
        future: profileViewModel.getProfile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return _buildUser(context);
            } else {
              return _buildUser(context, profile: snapshot.data);
            }
          }
        },
      ),
    );
  }

  Widget _buildUser(BuildContext context, {Profile? profile}) {
    return SingleChildScrollView(
      child: Padding(
        padding: albumListPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              smallVerticalDistance,
              CircleAvatar(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                minRadius: 40.0,
                child: Text(
                  profile == null ? "?" : profile.firstName![0],
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              normalVerticalDistance,
              Text(
                profile == null
                    ? AppLocalizations.of(context)!.unknown
                    : "${profile.firstName} ${profile.lastName}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              xLargeVerticalDistance,
              ListTileWidget(
                title: Text(AppLocalizations.of(context)!.contactInfo),
                subtitle: profile == null
                    ? null
                    : Text(
                        "${AppLocalizations.of(context)!.emailAddress}: ${profile.email}"),
                leadingIconData: Icons.perm_contact_calendar_rounded,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactInfoScreen(
                      profileViewModel: profileViewModel,
                      updateProfile: rebuild,
                      profile: profile,
                    ),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
