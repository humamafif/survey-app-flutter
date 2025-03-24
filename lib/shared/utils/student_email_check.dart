bool isStudentEmail(String email) {
  final regex = RegExp(r'^\d{15}@student\.uin-malang\.ac\.id$');

  return regex.hasMatch(email);
}

void debugEmailValidation(String email) {
  final regex = RegExp(r'^\d{15}@student\.uin-malang\.ac\.id$');
  print("Email: '$email'"); // Perhatikan apakah ada spasi tambahan
  print("Email Length: ${email.length}"); // Cek panjang email
  print("Matches Regex: ${regex.hasMatch(email)}");
}
