import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme(
        primary: Color.fromRGBO(35, 47, 103, 1),
        onPrimary: Colors.white,
        secondary: Color.fromARGB(255, 227, 215, 202),
        onSecondary: Colors.black,
        tertiary: Color.fromARGB(255, 76, 161, 126),
        onTertiary: Colors.white,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        primaryVariant: Colors.deepPurple,
        secondaryVariant: Colors.amber,
        background: Colors.white,
        onBackground: Colors.grey.shade100),
    // Additional theme settings can be added here
  );
}
