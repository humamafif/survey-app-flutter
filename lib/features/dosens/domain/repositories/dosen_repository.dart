import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';

abstract class DosenRepository {
  Future<Either<Failure, List<DosenEntity>>> getAllDosen();
  Future<Either<Failure, DosenEntity>> getDosenById(String id);
  Future<Either<Failure, DosenEntity>> getDosenByName(String id);
}
