import 'package:survey_app/core/app/app_exports.dart';

class SigninWithGoogleUsecase {
  final AuthRepository repository;

  SigninWithGoogleUsecase({required this.repository});
  Future<Either<Failure, UserEntity>> call() {
    return repository.signInWithGoogle();
  }
}
