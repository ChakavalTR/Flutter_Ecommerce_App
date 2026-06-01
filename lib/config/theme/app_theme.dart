import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //! Main Colors
  static const Color primary = Color(0xFF6C4DFF);
  static const Color primaryDark = Color(0xFF4F35D9);
  static const Color secondary = Color(0xFFFF3D71);

  //! Light Mode Colors
  static const Color lightBg = Color(0xFFFFFFFF);
  static const Color softBg = Color(0xFFF7F7FB);
  static const Color cardBg = Color(0xFFF9F9FC);

  //! Dark Mode Colors
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkSoft = Color(0xFF111827);

  //! Text Colors
  static const Color darkText = Color(0xFF111827);
  static const Color greyText = Color(0xFF8A8A99);
  static const Color lightText = Color(0xFFFFFFFF);

  //! Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFFB020);
  static const Color danger = Color(0xFFFF3D3D);

  //! LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      scaffoldBackgroundColor: lightBg,
      primaryColor: primary,

      textTheme: GoogleFonts.poppinsTextTheme(),

      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        background: lightBg,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: lightBg,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: darkText, size: 26),
        titleTextStyle: GoogleFonts.poppins(
          color: darkText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: softBg,

        hintStyle: GoogleFonts.poppins(color: greyText, fontSize: 14),

        prefixIconColor: greyText,
        suffixIconColor: greyText,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 1.3),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: lightText,
          elevation: 0,
          minimumSize: const Size(double.infinity, 54),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightBg,
        elevation: 0,
        selectedItemColor: primary,
        unselectedItemColor: greyText,

        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        type: BottomNavigationBarType.fixed,
      ),

      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  //! DARK THEME
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: darkBg,
      primaryColor: primary,

      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        background: darkBg,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,

        iconTheme: const IconThemeData(color: lightText, size: 26),

        titleTextStyle: GoogleFonts.poppins(
          color: lightText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSoft,

        hintStyle: GoogleFonts.poppins(color: greyText, fontSize: 14),

        prefixIconColor: greyText,
        suffixIconColor: greyText,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 1.3),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: lightText,
          elevation: 0,
          minimumSize: const Size(double.infinity, 54),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkBg,
        elevation: 0,
        selectedItemColor: primary,
        unselectedItemColor: greyText,

        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        type: BottomNavigationBarType.fixed,
      ),

      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  //! Box Shadow
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 18,
      offset: const Offset(0, 8),
    ),
  ];

  //! Border Radius
  static BorderRadius radius16 = BorderRadius.circular(16);
  static BorderRadius radius20 = BorderRadius.circular(20);
  static BorderRadius radius24 = BorderRadius.circular(24);
}
