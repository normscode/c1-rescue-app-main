import 'package:flutter/material.dart';
import 'widget_themes/elevated_button_themes.dart';
import 'widget_themes/icon_button_themes.dart';
import 'widget_themes/outlined_button_themes.dart';
import 'widget_themes/text_formfield_theme.dart';
import 'widget_themes/text_theme.dart';


class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    primaryColor: const Color(0xFFFFE400),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFE400),
      secondary: const Color(0xFF880000)
    ),
    outlinedButtonTheme: ROutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: RElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    iconTheme: RIconButtonTheme.lightIconButtonTheme,
  );
}
