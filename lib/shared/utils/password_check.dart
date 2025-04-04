import 'package:survey_app/core/app/app_export.dart';

bool handlePassword(String password, BuildContext context) {
  if (password == "") {
    showSnackbar(context, "Password tidak boleh kosong!", Colors.red);
    return false;
  }

  if (password.length < 8) {
    showSnackbar(context, "Password minimal 8 karakter!", Colors.red);
    return false;
  }

  return true;
}
