import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signout_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase signInUseCase;
  final SignupUsecase signUpUseCase;
  final SignoutUsecase signOutUseCase;
  final CheckAuthUsecase checkAuthUsecase;

  AuthBloc({
    required this.checkAuthUsecase,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      print("🚀 SignInEvent dipanggil dengan email: ${event.email}");

      emit(AuthLoading());
      final result = await signInUseCase(event.email, event.password);

      result.fold(
        (failure) {
          print("❌ Sign-in gagal: ${failure.message}");
          emit(AuthFailure(failure.message));
        },
        (user) {
          print("✅ Sign-in sukses! Selamat datang, ${user.email}");
          emit(AuthSuccess(user));
        },
      );
    });

    on<SignUpEvent>((event, emit) async {
      print("📩 SignUpEvent dipanggil dengan email: ${event.email}");

      emit(AuthLoading());
      final result = await signUpUseCase(event.email, event.password);

      result.fold(
        (failure) {
          print("❌ Sign-up gagal: ${failure.message}");
          emit(AuthFailure(failure.message));
        },
        (user) {
          print("🎉 Sign-up sukses! Akun ${user.email} berhasil dibuat.");
          emit(AuthSuccess(user));
        },
      );
    });

    on<SignOutEvent>((event, emit) async {
      print("👋 SignOutEvent dipanggil. User akan logout...");

      await signOutUseCase(); // Lakukan proses logout

      print("✅ User berhasil logout. Memancarkan state Unauthenticated...");
      emit(Unauthenticated()); // Pastikan state berubah ke Unauthenticated
    });

    on<CheckAuthEvent>((event, emit) async {
      print("🔥 CheckAuthEvent dipanggil...");

      emit(AuthLoading());

      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print("🔴 Tidak ada user yang login.");
        emit(Unauthenticated());
        return;
      }

      try {
        print("🔄 Reload user untuk memastikan status terbaru...");
        await currentUser.reload();
        print("✅ Reload user berhasil!");
      } catch (e) {
        print("❌ Error saat reload user: $e");

        // Kalau error karena user nggak ditemukan, langsung Unauthenticated aja
        if (e.toString().contains('user-not-found')) {
          print(
            "🚨 User sudah dihapus dari Firebase. Set status ke Unauthenticated.",
          );
        }

        emit(Unauthenticated());
        return;
      }

      final result = await checkAuthUsecase();

      result.fold(
        (failure) {
          print("❌ Gagal mendapatkan user dari usecase: ${failure.message}");
          emit(Unauthenticated());
        },
        (user) {
          if (user != null) {
            print("✅ User ditemukan: ${user.email}");
            emit(AuthSuccess(user));
          } else {
            print("🔴 Tidak ada user yang login.");
            emit(Unauthenticated());
          }
        },
      );
    });
  }
}
