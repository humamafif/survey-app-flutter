import 'package:flutter/material.dart';

class AppColor {
  // Private constructor to prevent instantiation
  AppColor._();

  // Primary colors
  static const Color primaryColor = Color(
    0xFF6B8FBE,
  ); // Soft blue - warna utama
  static const Color secondaryColor = Color(
    0xFFAED1E6,
  ); // Light blue - warna sekunder

  // Base colors
  static const Color backgroundColor = Color(
    0xFFF8F9FA,
  ); // Off-white background
  static const Color surfaceColor = Color(
    0xFFFFFFFF,
  ); // Pure white for cards/surfaces

  // Text colors
  static const Color textPrimary = Color(
    0xFF2D3E50,
  ); // Dark blue-gray for main text
  static const Color textSecondary = Color(
    0xFF617489,
  ); // Medium blue-gray for secondary text
  static const Color textDisabled = Color(
    0xFFA0ADBA,
  ); // Light gray for disabled/hint text

  // Semantic colors
  static const Color success = Color(
    0xFF9BCF9C,
  ); // Pastel green for success states
  static const Color warning = Color(0xFFFFD6A5); // Pastel orange for warnings
  static const Color error = Color(0xFFF1A7A7); // Pastel red for errors
  static const Color info = Color(0xFFABD4F3); // Pastel blue for information

  // Accent colors for highlights and decorative elements
  static const Color accentPeach = Color(0xFFF8C4B4); // Peach accent
  static const Color accentLavender = Color(0xFFD7BFDC); // Lavender accent
  static const Color accentMint = Color(0xFFB8E0D2); // Mint green accent

  // Container and border colors
  static const Color borderColor = Color(0xFFE1E5EA); // Light gray for borders
  static const Color dividerColor = Color(
    0xFFECEFF1,
  ); // Very light gray for dividers

  // Interactive element colors
  static const Color buttonHighlight = Color(
    0xFF5D88BB,
  ); // Darker blue for interactions

  // Legacy colors (renamed for compatibility with existing code)
  static const Color black = textPrimary;
  static const Color green = success;
  static const Color ligthGreen = accentMint;
  static const Color darkGreen = Color(0xFF396F50);
  static const Color accentGreen = accentMint;
  static const Color yellow = warning;
  static const Color red = error;
}
