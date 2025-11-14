import 'package:survey_app/core/app/app_exports.dart';

class GetAllMataKuliahUsecase {
  final MataKuliahRepository repository;

  GetAllMataKuliahUsecase(this.repository);

  Future<Either<Failure, List<MataKuliahEntity>>> call() async {
    return await repository.getAllMataKuliah();
  }
}
