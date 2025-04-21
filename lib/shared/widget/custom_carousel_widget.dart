import 'package:carousel_slider/carousel_slider.dart';
import 'package:survey_app/core/app/app_exports.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.sp,
        autoPlay: true,
        enlargeCenterPage: true,
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
