import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theming/dimensions.dart';


class TabBarWidget extends StatefulWidget {

  const TabBarWidget({Key? key})
      : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  Widget _buildTab(String text, Icon icon) {
    return Tab( icon: icon, text: text, iconMargin: tabIconMargin,);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tabBarHeight,
      color: Theme.of(context).primaryColor,
      child: TabBar(
        labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
        labelStyle: Theme.of(context).textTheme.labelSmall,
        indicatorColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
        tabs: [
          _buildTab(AppLocalizations.of(context)!.browse.toUpperCase(), const Icon(Icons.search)),
          _buildTab(AppLocalizations.of(context)!.friends.toUpperCase(), const Icon(Icons.tag_faces)),
          _buildTab(AppLocalizations.of(context)!.news.toUpperCase(), const Icon(Icons.article_outlined)),
          _buildTab(AppLocalizations.of(context)!.profile.toUpperCase(), const Icon(Icons.account_circle_outlined)),
        ],
      ),
    );
  }
}
