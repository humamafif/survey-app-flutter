// lib/features/auth/domain/usecases/sign_up.dart
import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase({required this.repository});

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
