import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/auth/domain/entities/user_entity.dart';
import 'package:survey_app/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthUsecase {
  final AuthRepository repository;

  CheckAuthUsecase({required this.repository});
  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.getCurrentUser();
  }
}
