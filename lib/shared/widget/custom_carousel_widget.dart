import 'package:survey_app/core/app/app_exports.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items:
          [1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return CustomCardCarousel(index: i);
              },
            );
          }).toList(),
    );
  }
}
