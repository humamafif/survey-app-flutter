import 'package:survey_app/core/app/app_exports.dart';

class SignupWithGoogleUsecase {
  final AuthRepository repository;

  SignupWithGoogleUsecase({required this.repository});
  Future<Either<Failure, UserEntity>> call() {
    return repository.signUpWithGoogle();
  }
}
