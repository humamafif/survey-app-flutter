import 'package:survey_app/core/app/app_export.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// ✅ Event Login
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// ✅ Event Register
class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// ✅ Event Logout
class SignOutEvent extends AuthEvent {}

// ✅ Event Cek Autentikasi
class CheckAuthEvent extends AuthEvent {}
