import 'package:survey_app/core/app/app_exports.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase({required this.repository});

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
