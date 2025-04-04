import 'package:survey_app/core/app/app_export.dart';

class CheckAuthUsecase {
  final AuthRepository repository;

  CheckAuthUsecase({required this.repository});
  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.getCurrentUser();
  }
}
