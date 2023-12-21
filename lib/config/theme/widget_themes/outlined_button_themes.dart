import 'package:flutter/material.dart';

/* Light and Dark Outlined Button Themes */
class ROutlinedButtonTheme {
  ROutlinedButtonTheme._(); // To Avoid Creating Instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: const Color(0xFF272727),
      side: const BorderSide(color: Color(0xFF272727)),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: const Color(0xffffffff),
      side: const BorderSide(color: Color(0xffffffff)),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  );
}
