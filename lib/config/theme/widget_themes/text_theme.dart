import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: 15.0, fontWeight: FontWeight.bold, color: const Color(0xFF000000)),
    displayMedium: GoogleFonts.montserrat(
        fontSize: 13.0, fontWeight: FontWeight.w700, color: const Color(0xFF000000)),
    displaySmall: GoogleFonts.poppins(
        fontSize: 19.0, fontWeight: FontWeight.w700, color: const Color(0xFF000000)),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
    displayMedium: GoogleFonts.montserrat(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: const Color(0xffffffff)),
    displaySmall: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: const Color(0xffffffff)),
  );
}
