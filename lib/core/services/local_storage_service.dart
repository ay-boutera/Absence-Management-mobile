import 'package:abs/config/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  // Theme
  Future<void> setThemeMode(ThemeMode mode) async {
    await prefs.setString(
      AppStrings.themeMode,
      mode.name, // light / dark / system
    );
  }

  ThemeMode getThemeMode() {
    final value = prefs.getString(AppStrings.themeMode);
    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.light,
    );
  }

  // Language
  Future<void> setLanguage(String code) async {
    await prefs.setString(AppStrings.languageCode, code);
  }

  String getLanguage() {
    return prefs.getString(AppStrings.languageCode) ?? 'en';
  }
}
