import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/domain/repositories/dosen_repository.dart';

class GetDosenBynameUsecase {
  final DosenRepository repository;

  GetDosenBynameUsecase(this.repository);

  Future<Either<Failure, DosenEntity>> call(String name) async {
    return await repository.getDosenByName(name);
  }
}
