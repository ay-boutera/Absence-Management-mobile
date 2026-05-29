import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Helper to build a TextTheme with dual-font support
  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontFamily: 'Figtree',
        fontFamilyFallback: ['Cairo'],
      ),
    );
  }

  // --- LIGHT THEME ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Figtree',
      fontFamilyFallback: ['Cairo'],
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        brightness: Brightness.light,
      ),
      textTheme: _buildTextTheme(ThemeData.light().textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // --- DARK THEME ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Figtree',
      fontFamilyFallback: ['Cairo'],
      brightness: Brightness.dark,
      primaryColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        brightness: Brightness.dark,
      ),
      textTheme: _buildTextTheme(ThemeData.dark().textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
