import 'package:survey_app/core/app/app_exports.dart';

abstract class MataKuliahRepository {
  Future<Either<Failure, List<MataKuliahEntity>>> getAllMataKuliah();
  Future<Either<Failure, MataKuliahEntity>> getMataKuliahById(String id);
  Future<Either<Failure, List<MataKuliahEntity>>> getMataKuliahByDosenId(
    String dosenId,
  );
}
