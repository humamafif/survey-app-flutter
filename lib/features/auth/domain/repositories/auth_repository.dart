import 'package:survey_app/core/app/app_export.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
