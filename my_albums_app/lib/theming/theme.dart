import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData myThemeData = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme(
    surface: surface,
    primary: primaryColor,
    onPrimary: onPrimary,
    secondary: secondary,
    background: background,
    onSurface: onSurface,
    onError: onError,
    error: error,
    onBackground: onBackground,
    onSecondary: onSecondary,
    brightness: Brightness.light,
    outline: borderColor,
    primaryContainer: primaryColor,
    onPrimaryContainer: unselectedTabBarLabel,
  ),
);
