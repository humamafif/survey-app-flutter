import 'package:survey_app/core/app/app_exports.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("📱 LOGIN PAGE");
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                return Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "Selamat Datang \ndi Survey App Program Studi Teknik Informatika",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 32.sp,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.verticalSpace,
                      ElevatedButton(
                        onPressed: () {
                          print("🚀 SignInWithGoogleEvent!");
                          context.read<AuthBloc>().add(SignInWithGoogleEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.sp),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/logo/logo_uin.png",
                                width: 24.sp,
                                height: 24.sp,
                              ),
                              8.horizontalSpace,
                              Text(
                                "SIGN IN WITH STUDENT ACCOUNT",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
