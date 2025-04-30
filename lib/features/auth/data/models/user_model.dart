import 'package:survey_app/core/app/app_exports.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, super.email, super.name});

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email, name: user.displayName);
  }
  // from json list
  factory UserModel.fromJsonList(List<dynamic> json) {
    return UserModel(
      uid: json[0]['google_id'] as String,
      email: json[0]['email'] as String,
      name: json[0]['name'] as String,
    );
  }

  // model to json
  Map<String, dynamic> toJson() {
    return {'role_id': 2, 'name': name, 'email': email, 'google_id': uid};
  }
}
