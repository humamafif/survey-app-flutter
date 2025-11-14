import 'package:survey_app/core/app/app_exports.dart';

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
