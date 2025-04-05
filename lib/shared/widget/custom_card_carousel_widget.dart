import 'package:survey_app/core/app/app_exports.dart';

class CustomCardCarousel extends StatelessWidget {
  const CustomCardCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(13.0),
      ),
    );
  }
}
