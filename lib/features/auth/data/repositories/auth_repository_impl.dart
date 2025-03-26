import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:survey_app/features/auth/domain/entities/user_entity.dart';
import 'package:survey_app/features/auth/domain/repositories/auth_repository.dart';

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
      return Left(AuthFailure("⚠️ $e"));
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
    } catch (e) {
      return Left(AuthFailure("⚠️ Gagal SignUp"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure("⚠️ Gagal SignOut"));
    }
  }

  @override
  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrent();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure("⚠️ Gagal get current user"));
    }
  }
}
