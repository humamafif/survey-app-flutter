import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/shared/pages/loading_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailureState) {
            showSnackbar(
              context,
              state.message,
              AppColor.error,
              SnackBarType.fail,
            );
          } else if (state is LoginSuccess || state is Authenticated) {
            String message =
                state is LoginSuccess ? state.message : "Login berhasil";

            showSnackbar(
              context,
              message,
              AppColor.success,
              SnackBarType.success,
            );
            Future.delayed(Duration(milliseconds: 200), () {
              if (context.mounted) context.go("/home");
            });
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingPage();
          }
          return _buildLoginContent(context);
        },
      ),
    );
  }

  Widget _buildLoginContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
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
                      final authState = context.read<AuthBloc>().state;
                      if (authState is! AuthLoading) {
                        context.read<AuthBloc>().add(SignInWithGoogleEvent());
                      }
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
            ),
          ],
        ),
      ),
    );
  }
}
