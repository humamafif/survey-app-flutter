import 'package:survey_app/core/app/app_exports.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailureState) {
                    showSnackbar(context, state.message, AppColor.error);
                  } else if (state is LoginSuccess) {
                    showSnackbar(context, state.message, AppColor.success);
                    Future.microtask(() => context.go("/home"));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang \ndi Aplikasi Survey Program Studi \nTeknik Informatika",
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        12.verticalSpace,
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              SignInWithGoogleEvent(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.surfaceColor,
                            foregroundColor: AppColor.textPrimary,
                            elevation: 2,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 4.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/logo/logo_uin.png",
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                16.horizontalSpace,
                                Text(
                                  "SIGN IN WITH STUDENT ACCOUNT",
                                  style: AppTextStyles.buttonText.copyWith(
                                    color: AppColor.textPrimary,
                                    fontSize: 14.sp,
                                  ),
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
      ),
    );
  }
}
