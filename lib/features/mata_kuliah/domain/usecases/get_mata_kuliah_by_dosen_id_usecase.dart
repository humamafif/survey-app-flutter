import 'package:survey_app/core/app/app_exports.dart';

class GetMataKuliahByDosenIdUsecase {
  final MataKuliahRepository repository;

  GetMataKuliahByDosenIdUsecase(this.repository);

  Future<Either<Failure, List<MataKuliahEntity>>> call(String dosenId) async {
    return await repository.getMataKuliahByDosenId(dosenId);
  }
}
