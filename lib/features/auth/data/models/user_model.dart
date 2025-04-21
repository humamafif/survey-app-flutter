import 'package:survey_app/core/app/app_exports.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, super.email, super.name});

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email, name: user.displayName);
  }
}
