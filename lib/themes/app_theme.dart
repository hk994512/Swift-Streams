import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final _defaultColor = Colors.deepOrange;
  static ThemeData get appTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: _defaultColor,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.mooli(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.mooli(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.mooli(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(weight: 70),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5,
        selectedLabelStyle: GoogleFonts.mooli(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        selectedIconTheme: IconThemeData(color: _defaultColor),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.mooli(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
        backgroundColor: _defaultColor,
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(shape: CircleBorder()),
      ),
    );
  }
}
