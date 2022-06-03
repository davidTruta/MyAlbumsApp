import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/main/tab_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        : TabBarWidget(
            screens: [
              {'screen': AlbumsScreen(), 'icon':const Icon(Icons.search), 'label': Text(AppLocalizations.of(context)!.browse.toUpperCase())},
              {'screen': const TempScreen(), 'icon':const Icon(Icons.emoji_emotions_outlined), 'label': Text(AppLocalizations.of(context)!.friends.toUpperCase())},
              const {'screen': TempScreen(), 'icon':Icon(Icons.question_mark), 'label': Text("??????")},
              {'screen': const TempScreen(), 'icon':const Icon(Icons.newspaper), 'label': Text(AppLocalizations.of(context)!.news.toUpperCase())},
              {'screen': const TempScreen(), 'icon':const Icon(Icons.account_circle_outlined), 'label': Text(AppLocalizations.of(context)!.profile.toUpperCase())},
            ],
          );
  }
}
