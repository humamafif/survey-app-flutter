import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:survey_app/core/app/app_exports.dart';

bool handlePassword(String password, BuildContext context) {
  if (password == "") {
    showSnackbar(
      context,
      "Password tidak boleh kosong!",
      AppColor.error,
      SnackBarType.fail,
    );
    return false;
  }

  if (password.length < 8) {
    showSnackbar(
      context,
      "Password minimal 8 karakter!",
      AppColor.error,
      SnackBarType.fail,
    );
    return false;
  }

  return true;
}
