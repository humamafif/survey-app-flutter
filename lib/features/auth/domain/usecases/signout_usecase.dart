import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/auth/domain/repositories/auth_repository.dart';

class SignoutUsecase {
  final AuthRepository repository;

  SignoutUsecase({required this.repository});

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
