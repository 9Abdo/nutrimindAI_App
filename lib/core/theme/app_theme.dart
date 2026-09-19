import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimind/core/constant/app_color.dart';

class AppTheme {
  // ----------------------------------------------------
  // LIGHT THEME
  // ----------------------------------------------------
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.cairoTextTheme(
      ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.lightScaffoldBackground,

      colorScheme: const ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.accentColor,
        surface: AppColor.lightSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColor.lightTextPrimary,
        error: Colors.redAccent,
        outline: AppColor.lightBorder,
      ),

      textTheme: baseTextTheme.apply(
        bodyColor: AppColor.lightTextPrimary,
        displayColor: AppColor.lightTextPrimary,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.lightScaffoldBackground,
        foregroundColor: AppColor.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.primaryColor),
        titleTextStyle: GoogleFonts.cairo(
          color: AppColor.primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColor.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColor.lightBorder, width: 0.8),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.lightSurface,
        hintStyle: GoogleFonts.cairo(color: AppColor.lightTextSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColor.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColor.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
            width: 1.5,
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColor.lightBorder,
        thickness: 1,
        space: 1,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColor.lightSurface,
        surfaceTintColor: Colors.transparent,
      ),

      dialogTheme: const DialogThemeData(
        backgroundColor: AppColor.lightSurface,
      ),
    );
  }

  // ----------------------------------------------------
  // DARK THEME
  // ----------------------------------------------------
  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.cairoTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.darkScaffoldBackground,

      colorScheme: const ColorScheme.dark(
        primary: AppColor.primaryColor,
        secondary: AppColor.accentColor,
        surface: AppColor.darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColor.darkTextPrimary,
        error: Colors.redAccent,
        outline: AppColor.darkBorder,
      ),

      textTheme: baseTextTheme.apply(
        bodyColor: AppColor.darkTextPrimary,
        displayColor: AppColor.darkTextPrimary,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.darkScaffoldBackground,
        foregroundColor: AppColor.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.primaryColor),
        titleTextStyle: GoogleFonts.cairo(
          color: AppColor.primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColor.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColor.darkBorder, width: 0.8),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.darkSurface,
        hintStyle: GoogleFonts.cairo(color: AppColor.darkTextSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColor.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColor.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
            width: 1.5,
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColor.darkBorder,
        thickness: 1,
        space: 1,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColor.darkSurface,
        surfaceTintColor: Colors.transparent,
      ),

      dialogTheme: const DialogThemeData(backgroundColor: AppColor.darkSurface),
    );
  }
}
