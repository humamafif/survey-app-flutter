import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/mata_kuliah/data/datasources/mata_kuliah_data_source.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/domain/repositories/mata_kuliah_repository.dart';

class MataKuliahRepositoryImpl implements MataKuliahRepository {
  final MataKuliahRemoteDataSource remoteDataSource;

  MataKuliahRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MataKuliahEntity>>> getAllMataKuliah() async {
    try {
      final result = await remoteDataSource.getAllMataKuliah();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MataKuliahEntity>> getMataKuliahById(String id) async {
    try {
      final result = await remoteDataSource.getMataKuliahById(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MataKuliahEntity>>> getMataKuliahByDosenId(
    String dosenId,
  ) async {
    try {
      final result = await remoteDataSource.getMataKuliahByDosenId(dosenId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
