import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:my_albums_app/ui/views/album_screen.dart';
import 'package:my_albums_app/ui/views/no_internet_screen.dart';
import 'package:my_albums_app/ui/views/splash_screen.dart';
import 'package:my_albums_app/ui/views/tabs_screen.dart';
import 'package:my_albums_app/ui/views/temp_screen.dart';
import 'package:my_albums_app/view_models/album_view_model.dart';
import 'package:my_albums_app/view_models/photo_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _timer;
  static final AlbumsViewModel albumsViewModel = AlbumsViewModel();
  static final PhotosViewModel photosViewModel = PhotosViewModel();

  @override
  initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () => {setState(() {})});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Nunito',
          primarySwatch:
              const Color.fromRGBO(68, 108, 194, 1).toMaterialColor()),
      home: _timer.isActive
          ? const SplashScreen()
          : TabsScreen(
              albumsViewModel: albumsViewModel,
            ),
      routes: {
        AlbumScreen.routeName: (context) => AlbumScreen(
              viewModel: photosViewModel,
            ),
        NoInternetScreen.routeName: (context) => const NoInternetScreen(),
        TempScreen.routeName: (context) => const TempScreen(),
      },
    );
  }
}
