import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F1923),
    primaryColor: const Color(0xFFFF4655),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F1923),
      elevation: 0,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}