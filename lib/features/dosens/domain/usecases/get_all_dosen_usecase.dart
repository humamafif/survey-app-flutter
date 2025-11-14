import 'package:survey_app/core/app/app_exports.dart';

class GetAllDosenUsecase {
  final DosenRepository repository;

  GetAllDosenUsecase(this.repository);

  Future<Either<Failure, List<DosenEntity>>> call() async {
    return await repository.getAllDosen();
  }
}
