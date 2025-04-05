import 'package:survey_app/core/app/app_exports.dart';

class AuthFailure extends Failure {
  const AuthFailure(super.message);

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      case "email-already-in-use":
        return const AuthFailure("Email sudah digunakan. Gunakan email lain.");
      case "weak-password":
        return const AuthFailure(
          "Password terlalu lemah. Gunakan minimal 8 karakter.",
        );
      case "invalid-email":
        return const AuthFailure("Format email tidak valid.");
      case "wrong-password":
        return const AuthFailure("Password salah. Coba lagi.");
      case "user-not-found":
        return const AuthFailure("Email tidak terdaftar.");
      case "invalid-credential":
        return const AuthFailure("Email atau password salah. Coba lagi.");
      default:
        return AuthFailure(
          "Terjadi kesalahan. Coba lagi nanti. ${code.toString()}",
        );
    }
  }
}
