import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/domain/repositories/dosen_repository.dart';

class GetAllDosenUsecase {
  final DosenRepository repository;

  GetAllDosenUsecase(this.repository);

  Future<Either<Failure, List<DosenEntity>>> call() async {
    return await repository.getAllDosen();
  }
}
