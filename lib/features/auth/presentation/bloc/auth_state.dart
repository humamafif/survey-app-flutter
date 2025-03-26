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
  final String message;
  LoginSuccess({required this.user, required this.message});

  @override
  List<Object> get props => [user];
}

// ✅ State Sukses Register
class RegisterSuccess extends AuthState {
  final String message;
  RegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

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
class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState(this.message);

  @override
  List<Object> get props => [message];
}
