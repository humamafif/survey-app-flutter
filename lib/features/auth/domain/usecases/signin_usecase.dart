import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/auth/domain/entities/user_entity.dart';
import 'package:survey_app/features/auth/domain/repositories/auth_repository.dart';

class SigninUsecase {
  final AuthRepository repository;

  SigninUsecase({required this.repository});
  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
