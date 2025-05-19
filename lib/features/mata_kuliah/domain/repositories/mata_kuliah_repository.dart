import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';

abstract class MataKuliahRepository {
  Future<Either<Failure, List<MataKuliahEntity>>> getAllMataKuliah();
  Future<Either<Failure, MataKuliahEntity>> getMataKuliahById(String id);
  Future<Either<Failure, List<MataKuliahEntity>>> getMataKuliahByDosenId(
    String dosenId,
  );
}
