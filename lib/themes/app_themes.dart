// app_themes.dart
import 'package:flutter/material.dart';

import 'theme_constants.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightBackgroundColor,

    // AppBar theme for light mode
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: lightPrimaryColor),
      titleTextStyle: TextStyle(
        color: lightPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),

    // General icon theme for light mode
    iconTheme: const IconThemeData(color: darkPrimaryColor),

    // Text theme for light mode
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: blackColor,
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        color: blackColor,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        color: blackColor,
        fontSize: 12,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        color: primaryColor,
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        color: blackColor,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    ),

    // Floating Action Button (FAB) theme for light mode
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor,
    ),

    // TextButton theme for light mode
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(lightPrimaryColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ),

    // ElevatedButton theme for light mode
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(lightPrimaryColor),
        foregroundColor: WidgetStateProperty.all(whiteColor),
        textStyle: WidgetStateProperty.all(
          TextStyle(
              fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),

    //textfield
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: inactiveTextFieldColor,
        fontSize: 14.0,
      ),
      floatingLabelStyle: const TextStyle(
        color: darkActiveTextFieldColor,
        fontSize: 16.0,
      ),
      hintStyle: const TextStyle(
        color: inactiveTextFieldColor,
        fontSize: 14.0,
      ),
      helperStyle: const TextStyle(
        color: inactiveTextFieldColor,
        fontSize: 12.0,
      ),
      errorStyle: const TextStyle(
        color: redColor,
        fontSize: 12.0,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      isDense: false,
      filled: true,
      fillColor: TextFieldColor,
      focusColor: darkActiveTextFieldColor,
      hoverColor: inactiveTextFieldColor.withOpacity(0.2),

      // Borders
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: inactiveTextFieldColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide:
            const BorderSide(color: darkActiveTextFieldColor, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: inactiveTextFieldColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: redColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: redColor, width: 2.0),
      ),

      iconColor: inactiveTextFieldColor,
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return darkActiveTextFieldColor;
        }
        return inactiveTextFieldColor;
      }),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return darkActiveTextFieldColor;
        }
        return inactiveTextFieldColor;
      }),

      // Constraints for better alignment
      constraints: const BoxConstraints(
        minHeight: 50,
        maxHeight: 60,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkBackgroundColor,

    // AppBar theme for dark mode
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: darkPrimaryColor),
      titleTextStyle: TextStyle(
        color: darkPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),

    // General icon theme for dark mode
    iconTheme: const IconThemeData(color: darkPrimaryColor),

    // Text theme for dark mode
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: whiteColor, fontSize: 16),
      bodyMedium: TextStyle(color: whiteColor, fontSize: 14),
    ),

    // Floating Action Button (FAB) theme for dark mode
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkPrimaryColor,
    ),

    // TextButton theme for dark mode
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(darkPrimaryColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ),

// ElevatedButton theme for dark mode
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(darkPrimaryColor),
        foregroundColor: WidgetStateProperty.all(whiteColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),

// TextField Theme
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: inactiveTextFieldColor,
        fontSize: 14.0,
      ),
      floatingLabelStyle: const TextStyle(
        color: darkActiveTextFieldColor,
        fontSize: 16.0,
      ),
      hintStyle: const TextStyle(
        color: inactiveTextFieldColor,
        fontSize: 14.0,
      ),
      helperStyle: const TextStyle(
        color: inactiveTextFieldColor,
        fontSize: 12.0,
      ),
      errorStyle: const TextStyle(
        color: redColor,
        fontSize: 12.0,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      isDense: false,
      filled: true,
      fillColor: TextFieldColor,
      focusColor: darkActiveTextFieldColor,
      hoverColor: inactiveTextFieldColor.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: inactiveTextFieldColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide:
            const BorderSide(color: darkActiveTextFieldColor, width: 2.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: inactiveTextFieldColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: redColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: redColor, width: 2.0),
      ),
      iconColor: inactiveTextFieldColor,
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return darkActiveTextFieldColor;
        }
        return inactiveTextFieldColor;
      }),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return darkActiveTextFieldColor;
        }
        return inactiveTextFieldColor;
      }),
      constraints: const BoxConstraints(
        minHeight: 50,
        maxHeight: 60,
      ),
    ),
  );
}
