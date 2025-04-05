import 'package:survey_app/core/app/app_exports.dart';

class SignoutUsecase {
  final AuthRepository repository;

  SignoutUsecase({required this.repository});

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
