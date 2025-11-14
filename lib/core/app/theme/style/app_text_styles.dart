import 'package:survey_app/core/app/app_exports.dart';

class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Headlines
  static final TextStyle h1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColor.black,
  );

  static final TextStyle h2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  static final TextStyle h3 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  // Body text
  static final TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    color: AppColor.black,
  );

  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColor.black,
  );

  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColor.black,
  );

  // Button text
  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Special styles
  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade700,
  );

  static final TextStyle error = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColor.error,
  );
}
