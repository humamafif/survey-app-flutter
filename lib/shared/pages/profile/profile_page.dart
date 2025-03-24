import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          print("🚪 User berhasil logout! Arahkan ke halaman login...");
          GoRouter.of(context).go('/login');
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              70.verticalSpace,
              CircleAvatar(radius: 80, backgroundColor: Colors.grey),
              12.verticalSpace,
              Text("Username"),
              4.verticalSpace,
              Text(user?.email ?? "No email"), // Mencegah error jika user null
              ElevatedButton(
                onPressed: () {
                  print("👋 Tombol Logout ditekan...");
                  context.read<AuthBloc>().add(SignOutEvent());
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
