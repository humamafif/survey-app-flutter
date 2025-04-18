import 'package:survey_app/core/app/app_exports.dart';

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
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (isStudentEmail(emailController.text, context) &&
                              handlePassword(
                                passwordController.text,
                                context,
                              )) {
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
                      ElevatedButton(
                        onPressed: () {
                          print("🚀 SignInWithGoogleEvent!");
                          context.read<AuthBloc>().add(SignInWithGoogleEvent());
                        },
                        child: Text("Sign In with Google"),
                      ),
                    ],
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
