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
        height: 150.sp,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 50.sp,
              height: 50.sp,
            ),
            8.verticalSpace,
            Text(title),
          ],
        ),
      ),
    );
  }
}
