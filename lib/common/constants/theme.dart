import 'package:flutter/material.dart';

// App theme
final ThemeData theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'Inter',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),

  // Buttons
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(Color(0xFF000000)),
      foregroundColor: const MaterialStatePropertyAll(Color(0xFFFFFFFF)),
      textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 18)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
      minimumSize: const MaterialStatePropertyAll(Size.fromHeight(54)),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    elevation: 1,
    shape: CircleBorder(),
  ),

  // Dialogs
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFFFFFFFF),
    surfaceTintColor: const Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),

  // Inputs
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(16),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFFD7D7D7)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFFBE5151)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFFBE5151)),
    ),
  ),

  // App Bar
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 80,
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    shape: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1)),
  ),
);
