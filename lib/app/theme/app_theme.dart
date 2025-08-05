import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // Set the default font family for the entire app
    fontFamily: 'Montserrat',

    // Define other theme properties
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: const Color(0xFF008080), // Example teal background
    brightness: Brightness.light,

    textTheme: const TextTheme(
      // You can define specific text styles here if needed
      // For example, if you want the headlineSmall to be bold by default
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600, // SemiBold
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400, // Regular
      ),
    ),

    // Style your buttons, app bars, etc.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // You can use the font here too, but it will be inherited from the main theme
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500, // Medium
        ),
      ),
    ),
  );

  // You can also define a darkTheme if you plan to support it
  // static final ThemeData darkTheme = ThemeData(...);
}