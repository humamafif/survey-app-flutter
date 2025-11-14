
import 'package:survey_app/core/app/app_exports.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColor.backgroundColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.sp,
                child: LoadingIndicator(
                  indicatorType: Indicator.pacman,
                  colors: [AppColor.primaryColor, AppColor.accentLavender],
                  strokeWidth: 2.0,
                  backgroundColor: AppColor.backgroundColor,
                  pathBackgroundColor: AppColor.primaryColor,
                ),
              ),
              4.verticalSpace,
              TypeWriter.text(
                "Loading....",
                repeat: true,
                alignment: Alignment.center,
                maxLines: 1,
                duration: const Duration(milliseconds: 100),
                style: TextStyle(color: AppColor.primaryColor, fontSize: 18.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
