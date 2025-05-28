import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> getDetailUser(String studentEmail);
}
