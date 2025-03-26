import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ✅ State untuk Inisialisasi Aplikasi
class AppStarted extends AuthState {}

// ✅ State Default
class AuthInitial extends AuthState {}

// ✅ State Loading
class AuthLoading extends AuthState {}

// ✅ State Sukses Login
class LoginSuccess extends AuthState {
  final UserEntity user;
  LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

// ✅ State Sukses Register
class RegisterSuccess extends AuthState {}

// ✅ State Authenticated (User Sudah Login)
class Authenticated extends AuthState {
  final UserEntity user;
  Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

// ✅ State Unauthenticated (User Belum Login)
class Unauthenticated extends AuthState {}

// ✅ State Gagal
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
