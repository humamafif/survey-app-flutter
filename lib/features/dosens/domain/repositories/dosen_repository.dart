import 'package:survey_app/core/app/app_exports.dart';

abstract class DosenRepository {
  Future<Either<Failure, List<DosenEntity>>> getAllDosen();
}
