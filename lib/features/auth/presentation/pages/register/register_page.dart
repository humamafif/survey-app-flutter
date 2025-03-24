// lib/features/auth/presentation/pages/register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:survey_app/shared/utils/student_email_check.dart';
import 'package:survey_app/shared/widget/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: emailController, labelText: "Email"),

            CustomTextField(
              controller: passwordController,
              labelText: "Password",
              isPassword: true,
            ),

            SizedBox(height: 20),
            Builder(
              builder: (context) {
                return BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    print("Listener: $state");
                    if (state is AuthFailure) {
                      print("SHOW SNACKBAR!");
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is AuthSuccess) {
                      // GoRouter.of(context).pop();
                      context.goNamed("/login");
                    }
                  },
                  builder: (context, state) {
                    print("STATE: ${state}");
                    if (state is AuthLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        debugEmailValidation(emailController.text);
                        context.read<AuthBloc>().add(
                          SignUpEvent(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      child: Text("Register"),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
