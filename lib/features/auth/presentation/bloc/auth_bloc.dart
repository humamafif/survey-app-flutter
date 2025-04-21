import 'package:survey_app/core/app/app_exports.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignoutUsecase signOutUseCase;
  final SigninWithGoogleUsecase signInWithGoogleUsecase;
  final CheckAuthUsecase checkAuthUsecase;

  AuthBloc({
    required this.checkAuthUsecase,
    required this.signInWithGoogleUsecase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
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
