import 'package:survey_app/core/app/app_exports.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase signInUseCase;
  final SignupUsecase signUpUseCase;
  final SignoutUsecase signOutUseCase;
  final SignupWithGoogleUsecase signUpWithGoogleUsecase;
  final SigninWithGoogleUsecase signInWithGoogleUsecase;
  final CheckAuthUsecase checkAuthUsecase;

  AuthBloc({
    required this.checkAuthUsecase,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signUpWithGoogleUsecase,
    required this.signInWithGoogleUsecase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    // ✅ Handle Login
    on<SignInEvent>((event, emit) async {
      print("🚀 SignInEvent dipanggil dengan email: ${event.email}");
      emit(AuthLoading());

      final result = await signInUseCase(event.email, event.password);

      result.fold(
        (failure) {
          print("❌ Sign-in gagal: ${failure.message}");
          emit(AuthFailureState(failure.message));
        },
        (user) {
          print("✅ Sign-in sukses! Selamat datang, ${user.email}");
          emit(LoginSuccess(user: user, message: "Login Success"));
          print("STATE login event: $state");

          emit(Authenticated(user: user));
          print("STATE login event: $state");
        },
      );
    });

    // ✅ Handle Register
    on<SignUpEvent>((event, emit) async {
      print("📩 SignUpEvent dipanggil dengan email: ${event.email}");
      emit(AuthLoading());

      final result = await signUpUseCase(event.email, event.password);

      await result.fold(
        (failure) async {
          print("❌ Sign-up gagal: ${failure.message}");
          emit(AuthFailureState(failure.message));
        },
        (user) async {
          print("🎉 Sign-up sukses! Akun ${user.email} berhasil dibuat.");
          emit(RegisterSuccess(message: "Registrasi Success"));
          print("STATE register event: $state");
          await FirebaseAuth.instance.signOut().then((_) {
            print("SIGNOUT DULU BESTIEH");

            if (!emit.isDone) {
              emit(Unauthenticated());
              print("STATE register event: $state");
            }
          });
        },
      );
    });

    // ✅ Handle Logout
    on<SignOutEvent>((event, emit) async {
      print("👋 SignOutEvent dipanggil. User akan logout...");
      await signOutUseCase();
      print("✅ User berhasil logout.");
      emit(Unauthenticated());
    });

    // ✅ Handle Cek Autentikasi
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
            emit(Authenticated(user: user));
            print("State: $state");
          } else {
            print("🔴 Tidak ada user yang login.");
            emit(Unauthenticated());
            print("State: $state");
          }
        },
      );
    });

    on<SignUpWithGoogleEvent>((event, emit) async {
      print("📧 SignUpWithGoogleEvent dipanggil...");
      emit(AuthLoading());

      final result = await signUpWithGoogleUsecase();

      result.fold(
        (failure) {
          print("❌ Gagal login dengan Google: ${failure.message}");
          emit(AuthFailureState(failure.message));
        },
        (user) async {
          print("✅ Login dengan Google sukses! Selamat datang, ${user.email}");
          emit(RegisterSuccess(message: "Register Success"));
          await FirebaseAuth.instance.signOut().then((_) {
            print("SIGNOUT DULU BESTIEH");

            if (!emit.isDone) {
              emit(Unauthenticated());
              print("STATE register event: $state");
            }
          });
        },
      );
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      print("📧 SignInWithGoogleEvent dipanggil...");
      emit(AuthLoading());

      final result = await signInWithGoogleUsecase();

      result.fold(
        (failure) {
          print("❌ Gagal login dengan Google: ${failure.message}");
          emit(AuthFailureState(failure.message));
        },
        (user) {
          print("✅ Login dengan Google sukses! Selamat datang, ${user.email}");
          emit(LoginSuccess(user: user, message: "Login Success"));
          emit(Authenticated(user: user));
        },
      );
    });
  }
}
