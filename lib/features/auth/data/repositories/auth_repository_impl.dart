import 'package:survey_app/core/app/app_export.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.signIn(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.signUp(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrent();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
