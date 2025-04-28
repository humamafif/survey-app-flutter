import 'package:survey_app/core/app/app_exports.dart';

bool handlePassword(String password, BuildContext context) {
  if (password == "") {
    showSnackbar(context, "Password tidak boleh kosong!", AppColor.red);
    return false;
  }

  if (password.length < 8) {
    showSnackbar(context, "Password minimal 8 karakter!", AppColor.red);
    return false;
  }

  return true;
}
