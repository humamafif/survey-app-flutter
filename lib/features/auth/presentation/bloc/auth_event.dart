import 'package:survey_app/core/app/app_exports.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignOutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}
