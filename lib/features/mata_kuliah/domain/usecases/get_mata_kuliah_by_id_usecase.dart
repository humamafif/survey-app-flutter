import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/domain/repositories/mata_kuliah_repository.dart';

class GetMataKuliahByIdUsecase {
  final MataKuliahRepository repository;

  GetMataKuliahByIdUsecase(this.repository);

  Future<Either<Failure, MataKuliahEntity>> call(String id) async {
    return await repository.getMataKuliahById(id);
  }
}
