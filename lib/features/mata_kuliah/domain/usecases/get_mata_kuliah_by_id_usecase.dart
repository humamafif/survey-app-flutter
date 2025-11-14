import 'package:survey_app/core/app/app_exports.dart';

class GetMataKuliahByIdUsecase {
  final MataKuliahRepository repository;

  GetMataKuliahByIdUsecase(this.repository);

  Future<Either<Failure, MataKuliahEntity>> call(String id) async {
    return await repository.getMataKuliahById(id);
  }
}
