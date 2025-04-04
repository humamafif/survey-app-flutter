import 'package:survey_app/core/app/app_export.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("📱 REGISTER PAGE");
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
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                print("Listener: $state");
                if (state is AuthFailureState) {
                  print("STATE: $state");
                  print("❌ Registrasi gagal: ${state.message}");
                  ScaffoldMessenger.of(context).clearSnackBars();
                  showSnackbar(context, state.message, AppColor.errorColor);
                } else if (state is RegisterSuccess) {
                  // Registrasi sukses, tampilkan snackbar & arahkan ke login
                  print("STATE Halaman Register: $state");
                  ScaffoldMessenger.of(context).clearSnackBars();
                  showSnackbar(context, state.message, AppColor.successColor);
                  Future.microtask(() => context.go("/login"));
                }
              },
              builder: (context, state) {
                print("STATE: ${state}");
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    if (isStudentEmail(emailController.text, context) &&
                        handlePassword(passwordController.text, context)) {
                      print("✅ Email valid, lanjutkan pendaftaran...");
                      context.read<AuthBloc>().add(
                        SignUpEvent(
                          emailController.text,
                          passwordController.text,
                        ),
                      );
                    } else {
                      print("⚠️ Email tidak valid, hentikan pendaftaran...");
                      return;
                    }
                  },
                  child: Text("Register"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
