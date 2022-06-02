import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  final Function setSelectedIndex;

  const TabBarWidget({Key? key, required this.setSelectedIndex})
      : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Theme.of(context).primaryColor,
      child: TabBar(
        padding: const EdgeInsets.only(top: 3),
        labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
        labelStyle: const TextStyle(
          fontSize: 14,
        ),
        indicatorColor: Theme.of(context).primaryColor,
        onTap: (value) => widget.setSelectedIndex(value),
        unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
        tabs: const [
          Tab(
              iconMargin: EdgeInsets.only(bottom: 3),
              icon: Icon(Icons.search),
              text: 'BROWSE'),
          Tab(
              iconMargin: EdgeInsets.only(bottom: 3),
              icon: Icon(Icons.tag_faces),
              text: 'FRIENDS'),
          Tab(
              iconMargin: EdgeInsets.only(bottom: 3),
              icon: Icon(Icons.article_outlined),
              text: 'NEWS'),
          Tab(
              iconMargin: EdgeInsets.only(bottom: 3),
              icon: Icon(Icons.account_circle_outlined),
              text: 'PROFILE'),
        ],
      ),
    );
  }
}
