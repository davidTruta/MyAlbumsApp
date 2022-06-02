import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/main/tab_bar_widget.dart';

import '../albums/list/albums_screen.dart';
import '../splash/splash_screen.dart';
import '../temp_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> titles = ['My Albums', 'My Friends', 'News', 'Profile'];
  late Timer _timer;
  int _selectedIndex = 0;

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () => {setState(() {})});
  }

  AppBar _buildAppBar(title) {
    return AppBar(
      centerTitle: false,
      title: Text(
        title,
        //AppLocalizations.of(context)!.helloWorld,
        style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w700),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _timer.isActive
        ? const SplashScreen()
        : DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: _buildAppBar(titles[_selectedIndex]),
              body: TabBarView(
                children: [
                  AlbumsScreen(),
                  const TempScreen(),
                  const TempScreen(),
                  const TempScreen(),
                ],
              ),
              bottomNavigationBar: TabBarWidget(
                setSelectedIndex: _setSelectedIndex,
              ),
            ),
          );
  }
}
