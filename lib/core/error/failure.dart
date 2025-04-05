import 'package:survey_app/core/app/app_exports.dart';

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
