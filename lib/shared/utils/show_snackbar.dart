import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:survey_app/core/app/app_exports.dart';

void showSnackbar(
  BuildContext context,
  String message,
  Color color,
  SnackBarType snackBarType,
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  IconSnackBar.show(
    context,
    label: message,
    snackBarType: snackBarType,
    backgroundColor: color,
    labelTextStyle: AppTextStyles.bodyLarge.copyWith(
      color: AppColor.backgroundColor,
    ),
  );
}
