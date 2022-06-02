import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_albums_app/screen/albums/details/album_screen.dart';
import 'package:my_albums_app/screen/error/no_internet_screen.dart';
import 'package:my_albums_app/screen/main/main_screen.dart';
import 'package:my_albums_app/screen/temp_screen.dart';
import 'package:my_albums_app/theming/theme.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Album App',
      theme: myThemeData,
      home: const MainScreen(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [ // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      routes: {
        AlbumScreen.routeName: (context) => AlbumScreen(),
        NoInternetScreen.routeName: (context) => const NoInternetScreen(),
        TempScreen.routeName: (context) => const TempScreen(),
      },
    );
  }
}
