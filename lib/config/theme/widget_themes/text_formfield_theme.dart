import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: const Color(0xFF272727),
    floatingLabelStyle: const TextStyle(color: Color(0xFF272727)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Color(0xFF272727)),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: const Color(0xFFFFE400),
    floatingLabelStyle: const TextStyle(color: Color(0xFFFFE400)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Color(0xFFFFE400)),
    ),
  );
}
