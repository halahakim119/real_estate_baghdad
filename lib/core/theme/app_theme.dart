import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme(
        primary: Color.fromRGBO(35, 47, 103, 1),
        onPrimary: Colors.white,
        secondary: Color.fromRGBO(227, 215, 202, 1),
        onSecondary: Colors.black,
        tertiary: Color.fromRGBO(134, 161, 76, 1),
        onTertiary: Colors.white,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
        surface: Color.fromRGBO(138, 78, 24, 1),
        onSurface: Colors.white,
        background: Colors.white,
        onBackground: Colors.grey.shade100),
  );
}
