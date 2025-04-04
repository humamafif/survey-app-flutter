import 'package:survey_app/core/app/app_export.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, super.email});

  factory UserModel.fromFirebase(dynamic user) {
    return UserModel(uid: user.uid, email: user.email);
  }
}
