import 'package:survey_app/core/app/app_exports.dart';

bool isValidStudentEmail(String email) {
  final regex = RegExp(r'^(\d{12})@student\.uin-malang\.ac\.id$');

  email = email.trim();
  if (!regex.hasMatch(email)) return false;

  String nim = regex.firstMatch(email)!.group(1)!;
  if (nim.length != 12) return false;

  String kodeProdi = nim.substring(2, 8);
  return kodeProdi == "060511";
}

bool isStudentEmail(String email, BuildContext context) {
  if (email.trim().isEmpty) {
    showSnackbar(context, "Email tidak boleh kosong!", Colors.red);
    return false;
  }

  if (!isValidStudentEmail(email)) {
    showSnackbar(
      context,
      "Gunakan email student UIN prodi Teknik Informatika!",
      Colors.red,
    );
    return false;
  }

  print("✅ Email valid dan boleh mendaftar!");
  return true;
}
