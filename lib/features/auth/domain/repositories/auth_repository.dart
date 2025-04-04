import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  Future<Either<Failure, UserEntity>> signUpWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
