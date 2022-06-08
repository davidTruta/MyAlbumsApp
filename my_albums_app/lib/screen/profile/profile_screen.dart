import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_screen.dart';
import 'package:my_albums_app/theming/dimensions.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/widgets/list_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
            title: Text(AppLocalizations.of(context)!.yourProfile,
                style: Theme.of(context).textTheme.headlineSmall),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications))
            ]),
        body: SingleChildScrollView(
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
                      "?",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  normalVerticalDistance,
                  Text(
                    AppLocalizations.of(context)!.unknown,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  xLargeVerticalDistance,
                  ListTileWidget(
                    title: const Text("Contact Info"),
                    leadingIconData: Icons.perm_contact_calendar_rounded,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactInfoScreen()));
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
