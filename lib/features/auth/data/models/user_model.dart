import 'package:survey_app/core/app/app_exports.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, super.email, super.name, super.id});

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email, name: user.displayName);
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      id: json['id'].toString(),
      uid: json['google_id'] as String,
      name: json['name'] as String,
    );
  }

  // model to json
  Map<String, dynamic> toJson() {
    return {'role_id': 2, 'name': name, 'email': email, 'google_id': uid};
  }
}
