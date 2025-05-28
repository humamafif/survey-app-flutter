import 'package:survey_app/core/app/app_exports.dart';

class GetDetailUserUsecase {
  final AuthRepository _userRepository;

  GetDetailUserUsecase(this._userRepository);

  Future<Either<Failure, UserEntity>> call(String userId) async {
    return await _userRepository.getDetailUser(userId);
  }
}
