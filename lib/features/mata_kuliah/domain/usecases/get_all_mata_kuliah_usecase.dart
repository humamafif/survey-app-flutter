import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/domain/repositories/mata_kuliah_repository.dart';

class GetAllMataKuliahUsecase {
  final MataKuliahRepository repository;

  GetAllMataKuliahUsecase(this.repository);

  Future<Either<Failure, List<MataKuliahEntity>>> call() async {
    return await repository.getAllMataKuliah();
  }
}
