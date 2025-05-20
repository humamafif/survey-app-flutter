import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/shared/utils/first_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.goNamed("/login");
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          }

          if (state is Authenticated) {
            return _buildHomeContent(firstName(state.user.name ?? "User"));
          } else {
            return Center(
              child: Text(
                "User tidak terautentikasi",
                style: AppTextStyles.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHomeContent(String name) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Halo, $name!", style: AppTextStyles.h2),
        centerTitle: false,
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCarousel(),
                12.verticalSpace,
                Text(
                  'Survey',
                  style: AppTextStyles.h3.copyWith(color: AppColor.textPrimary),
                ),
                16.verticalSpace,
                CustomCardSurvey(
                  color: AppColor.accentMint,
                  imagePath: "assets/icons/icon paper.png",
                  routeName: '/select-mata-kuliah-dosen',
                  title: "Survey Kepuasan Matakuliah",
                ),
                16.verticalSpace,
                CustomCardSurvey(
                  color: AppColor.accentPeach,
                  imagePath: "assets/icons/icon paper.png",
                  routeName: '/select-mata-kuliah-dosen',
                  title: "Survey Kinerja Dosen Genap 2024/2025",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
