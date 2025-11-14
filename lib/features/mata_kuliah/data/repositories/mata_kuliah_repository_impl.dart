import 'package:survey_app/core/app/app_exports.dart';

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
