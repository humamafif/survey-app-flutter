import 'package:survey_app/core/app/app_exports.dart';

class CustomCardSurvey extends StatelessWidget {
  const CustomCardSurvey({
    super.key,
    required this.color,
    required this.imagePath,
    required this.title,
    required this.routeName,
  });
  final Color color;
  final String imagePath;
  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(routeName),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 120.h, maxHeight: 150.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(13.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
