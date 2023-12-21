import 'package:flutter/material.dart';

/* Light and Dark Outlined Button Themes */
class RElevatedButtonTheme {
  RElevatedButtonTheme._(); // To Avoid Creating Instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: const Color(0xFFFFE400),
      backgroundColor: const Color(0xFF272727),
      side: const BorderSide(color: Color(0xFF272727)),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: const Color(0xFF272727),
      backgroundColor: const Color(0xffffffff),
      side: const BorderSide(color: Color(0xFF272727)),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );
}
