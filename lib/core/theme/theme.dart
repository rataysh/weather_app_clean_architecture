import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/theme/colors.dart';

class AppTheme {
  static TextTheme _textTheme(
      {required TextTheme base, required ColorScheme colorScheme}) {
    return base.copyWith(
      bodyMedium: GoogleFonts.roboto(
        textStyle: base.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      bodyLarge: GoogleFonts.roboto(
        textStyle: base.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      titleMedium: GoogleFonts.roboto(
        textStyle: base.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textLight,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textDark,
      error: AppColors.error,
      onError: AppColors.textLight,
      surface: Colors.white,
      onSurface: AppColors.textDark,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(
          base: ThemeData.light().textTheme, colorScheme: colorScheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
      ),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.textLight,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textDark,
      error: AppColors.error,
      onError: AppColors.textLight,
      surface: Color(0xFF1E1E1E),
      onSurface: AppColors.textLight,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(
          base: ThemeData.dark().textTheme, colorScheme: colorScheme),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
    );
  }

  static BoxDecoration get cardDecoration {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6.0,
          offset: Offset(1, 3),
        ),
      ],
    );
  }
}
