import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/dosens/data/datasources/dosen_remote_datasource.dart';
import 'package:survey_app/features/dosens/data/models/dosen_model.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/domain/repositories/dosen_repository.dart';

class DosenRepoImpl extends DosenRepository {
  final DosenRemoteDatasource dosenRemoteDatasource;

  DosenRepoImpl({required this.dosenRemoteDatasource});
  @override
  Future<Either<Failure, List<DosenEntity>>> getAllDosen() async {
    try {
      List<DosenModel> result = await dosenRemoteDatasource.getAllDosen();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
