import 'package:flutter/material.dart';
import 'package:survey_app/shared/utils/show_snackbar.dart';

bool isStudentEmail(String email, BuildContext context) {
  final regex = RegExp(r'^(\d{12})@student\.uin-malang\.ac\.id$');

  // Hapus spasi yang tidak terlihat
  email = email.trim();

  if (email == "") {
    showSnackbar(context, "Email tidak boleh kosong!", Colors.red);
    return false;
  }

  // Cek apakah format email sesuai
  if (!regex.hasMatch(email)) {
    showSnackbar(context, "Gunakan email student UIN!", Colors.red);
    return false;
  }

  // Ambil bagian NIM dari email
  String nim = regex.firstMatch(email)!.group(1)!;

  // Cek apakah panjang NIM 12 digit
  if (nim.length != 12) {
    showSnackbar(context, "Gunakan email student UIN!", Colors.red);
    return false;
  }

  // Ambil kode prodi (index ke-2 sampai ke-7)
  String kodeProdi = nim.substring(2, 8);

  // Validasi apakah kode prodi adalah "060511"
  if (kodeProdi != "060511") {
    showSnackbar(
      context,
      "Hanya prodi Teknik Informatika yang bisa mendaftar!",
      Colors.red,
    );
    return false;
  }

  print("✅ Email valid dan boleh mendaftar!");
  return true;
}
