import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // --- Titles & Headings ---

  // The "Sign in" title (Bold and Dark)
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.textPrimaryLight,
    letterSpacing: -0.5,
  );

  // Today Attendance headings or subsection titles
  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryLight,
  );

  // --- Body & Inputs ---

  // "Enter your email and password..." text
  static const TextStyle body1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryLight,
    height: 1.5, // Line height for better readability
  );

  // Input field text (the email and dots in the screenshot)
  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  // --- Specialized Styles ---

  // For the "Log In" button text
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // For "Forgot Password?" and "Remember me"
  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary, // Matches the #001951 or #3970EB blue
  );

  // H1 - Headers
  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // H2 - Sub-headers
  static const TextStyle h2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  // Body - Main
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Caption / Small
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600, // Semi-Bold
    color: Colors.white,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
