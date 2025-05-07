import 'package:survey_app/core/app/app_exports.dart';

class CustomCardCarousel extends StatelessWidget {
  const CustomCardCarousel({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner/banner $index.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
