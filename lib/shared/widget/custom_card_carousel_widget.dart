import 'package:survey_app/core/app/app_exports.dart';

class CustomCardCarousel extends StatelessWidget {
  const CustomCardCarousel({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner/banner $index.png'),
        fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(13.0),
      ),
    );
  }
}
