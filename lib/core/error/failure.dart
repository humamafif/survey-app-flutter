import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Terjadi kesalahan pada server"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "Tidak ada koneksi internet"]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = "Email atau password salah"]);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure([super.message = "User tidak ditemukan"]);
}

class UserAlreadyExistsFailure extends Failure {
  const UserAlreadyExistsFailure([super.message = "User sudah terdaftar"]);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message = "Input tidak valid"]);
}
