import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("📱 SPLASH SCREEN");
    // Cek status autentikasi saat splash screen dibuka
    context.read<AuthBloc>().add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          print("✅ User terautentikasi. Navigasi ke /home...");
          GoRouter.of(context).go('/home');
        } else if (state is Unauthenticated) {
          print("🚪 User tidak terautentikasi. Navigasi ke /login...");
          GoRouter.of(context).go('/login');
        }
      },
      child: Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(), // Animasi loading selama pengecekan auth
        ),
      ),
    );
  }
}
