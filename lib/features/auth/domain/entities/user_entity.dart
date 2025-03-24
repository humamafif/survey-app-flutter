import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;

  const UserEntity({required this.uid, this.email});

  @override
  List<Object?> get props => [uid, email];
}
