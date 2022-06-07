import 'package:flutter/material.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(AppLocalizations.of(context)!.yourProfile,style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Coming soon!'),
      ),
    );
  }
}
