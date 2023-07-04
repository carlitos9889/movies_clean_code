import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData get themeData => ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: false,
        ),
      );
}
