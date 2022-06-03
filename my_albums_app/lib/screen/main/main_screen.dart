import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/main/tab_bar_widget.dart';

import '../albums/albums_screen.dart';
import '../splash/splash_screen.dart';
import '../temp_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Timer _timer;

  @override
  initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return _timer.isActive
        ? const SplashScreen()
        : DefaultTabController(
            length: 4,
            child: Scaffold(
              body: TabBarView(
                children: [
                  AlbumsScreen(),
                  const TempScreen(),
                  const TempScreen(),
                  const TempScreen(),
                ],
              ),
              bottomNavigationBar: const TabBarWidget(),
            ),
          );
  }
}
