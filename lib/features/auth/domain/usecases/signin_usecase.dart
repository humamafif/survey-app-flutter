import 'package:survey_app/core/app/app_exports.dart';

class SigninUsecase {
  final AuthRepository repository;

  SigninUsecase({required this.repository});
  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
