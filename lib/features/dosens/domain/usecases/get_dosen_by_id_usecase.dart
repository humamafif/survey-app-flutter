import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/domain/repositories/dosen_repository.dart';

class GetDosenByIdUsecase {
  final DosenRepository repository;

  GetDosenByIdUsecase(this.repository);

  Future<Either<Failure, DosenEntity>> call(String id) async {
    return await repository.getDosenById(id);
  }
}
