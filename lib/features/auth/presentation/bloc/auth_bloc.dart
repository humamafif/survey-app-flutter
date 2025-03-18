import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signout_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase signInUseCase;
  final SignupUsecase signUpUseCase;
  final SignoutUsecase signOutUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signInUseCase(event.email, event.password);

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await signUpUseCase(event.email, event.password);

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<SignOutEvent>((event, emit) async {
      await signOutUseCase();
      emit(AuthInitial());
    });
  }
}
