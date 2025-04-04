import 'package:survey_app/core/app/app_export.dart';

class CustomCardSurvey extends StatelessWidget {
  const CustomCardSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed('/survey-form'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(13.0),
        ),
      ),
    );
  }
}
