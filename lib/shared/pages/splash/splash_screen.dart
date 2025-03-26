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
    context.read<AuthBloc>().add(CheckAuthEvent());
  }

  void _navigateWithDelay(BuildContext context, String route) {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        // Pastikan widget masih aktif sebelum navigasi
        GoRouter.of(context).go(route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print("📢 BlocListener menerima state baru: $state");
        if (state is Authenticated) {
          print("STATE: $state");
          print("✅ User terautentikasi. Navigasi ke /home dalam 3 detik...");
          _navigateWithDelay(context, "/home");
          // Future.microtask(() => GoRouter.of(context).go('/home'));
        } else if (state is RegisterSuccess) {
          print("STATE: $state");
          print("✅ User terautentikasi. Navigasi ke /login dalam 3 detik...");
          _navigateWithDelay(context, "/login");
        } else if (state is Unauthenticated) {
          print("STATE: $state");
          print(
            "🚪 User tidak terautentikasi. Navigasi ke /login dalam 3 detik...",
          );
          _navigateWithDelay(context, "/login");
        } else {
          print("state: $state");
        }
      },
      child: Scaffold(body: Center(child: Text("loading splash"))),
    );
  }
}
