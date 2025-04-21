import 'package:survey_app/core/app/app_exports.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? name;

  const UserEntity({required this.uid, this.email, this.name});

  @override
  List<Object?> get props => [uid, email, name];
}
