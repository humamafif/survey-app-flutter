import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/core/theme/colors/app_color.dart';
import 'package:survey_app/shared/utils/password_check.dart';
import 'package:survey_app/shared/utils/show_snackbar.dart';
import 'package:survey_app/shared/utils/student_email_check.dart';
import 'package:survey_app/shared/widget/custom_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("📱 LOGIN PAGE");
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            CustomTextField(
              labelText: "Email",
              hintText: "ex: 220605@student.uin-malang.ac.id",
              controller: emailController,
            ),
            12.verticalSpace,
            CustomTextField(
              labelText: "Password",
              hintText: "min 8 character",
              isPassword: true,
              controller: passwordController,
            ),
            12.verticalSpace,
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailureState) {
                  print("STATE: $state");
                  showSnackbar(context, state.message, AppColor.errorColor);
                } else if (state is LoginSuccess) {
                  print("STATE: $state");
                  showSnackbar(context, state.message, AppColor.successColor);
                  Future.microtask(() => context.go("/home"));
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (isStudentEmail(emailController.text, context) &&
                          handlePassword(passwordController.text, context)) {
                        print("🚀 Login!");
                        context.read<AuthBloc>().add(
                          SignInEvent(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                      }
                    },
                    child: Text("Sign In"),
                  ),
                );
              },
            ),

            Row(
              children: [
                Text("Belum punya akun?"),
                TextButton(
                  onPressed: () {
                    context.pushNamed("/register");
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
