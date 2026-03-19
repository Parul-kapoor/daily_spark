import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      //AppTitle
      headlineLarge: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 10,
            color: Colors.black54,
            offset: Offset(0, 2),
          ),
        ],
      ),
      //QuoteText
      bodyLarge: GoogleFonts.playfairDisplay(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.white,
      ),
      // Buttons / small text
      labelLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,
    brightness: Brightness.light,),
    scaffoldBackgroundColor: Colors.white,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple.shade600,
      secondary: Colors.orange.shade600,
    ),
    scaffoldBackgroundColor: Colors.black
  );
}