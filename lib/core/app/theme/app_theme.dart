import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_app/core/app/theme/colors/app_color.dart';
import 'package:survey_app/core/app/theme/style/app_text_styles.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Get the light theme for the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.backgroundColor,
      colorScheme: ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
        error: AppColor.error,
        background: AppColor.backgroundColor,
        surface: AppColor.surfaceColor,
        onPrimary: Colors.white,
        onSecondary: AppColor.textPrimary,
        onBackground: AppColor.textPrimary,
        onSurface: AppColor.textPrimary,
        onError: Colors.white,
      ),

      // Text theme
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headlineLarge: TextStyle(color: AppColor.textPrimary),
        headlineMedium: TextStyle(color: AppColor.textPrimary),
        headlineSmall: TextStyle(color: AppColor.textPrimary),
        bodyLarge: TextStyle(color: AppColor.textPrimary),
        bodyMedium: TextStyle(color: AppColor.textPrimary),
        bodySmall: TextStyle(color: AppColor.textSecondary),
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.backgroundColor,
        foregroundColor: AppColor.textPrimary,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h2,
        iconTheme: IconThemeData(color: AppColor.textPrimary),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColor.surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: AppColor.primaryColor.withOpacity(0.1),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppColor.primaryColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primaryColor,
          side: BorderSide(color: AppColor.primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Form themes
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surfaceColor,
        hintStyle: TextStyle(color: AppColor.textDisabled),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.error),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),

      // Other components
      dividerTheme: DividerThemeData(
        color: AppColor.dividerColor,
        thickness: 1,
        space: 24,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColor.textPrimary,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColor.primaryColor,
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColor.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: AppColor.borderColor),
      ),

      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColor.primaryColor;
          }
          return AppColor.textDisabled;
        }),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.surfaceColor,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.textDisabled,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
