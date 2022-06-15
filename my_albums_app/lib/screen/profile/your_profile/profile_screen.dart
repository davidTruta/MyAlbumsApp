import 'package:flutter/material.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_screen.dart';
import 'package:my_albums_app/screen/profile/your_profile/profile_view_model.dart';
import 'package:my_albums_app/theming/dimensions.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/widgets/list_tile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel profileViewModel =
      ProfileViewModel(ProfileRepo(SharedPreferences.getInstance()));

  @override
  initState(){
    super.initState();
    //TODO replace with input
    profileViewModel.fetchProfileStateData();
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
      body: StreamBuilder(
        stream: profileViewModel.getProfileStateData, //TODO replace with output
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final profileStateData = snapshot.data as ProfileStateData;

            if (profileStateData.profileState == ProfileState.unknown) {
              return _buildUser(context);
            } else {
              return _buildUser(context, profile: profileStateData.profile);
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
                      profile: profile,
                    ),
                  )).then((value) {
                    //TODO replace with input
                    profileViewModel.refreshProfileStateData();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
