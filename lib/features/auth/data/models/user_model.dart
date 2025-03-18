import 'package:survey_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, super.email});

  factory UserModel.fromFirebase(dynamic user) {
    return UserModel(uid: user.uid, email: user.email);
  }
}
