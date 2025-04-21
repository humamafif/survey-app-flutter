import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/shared/utils/first_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("📱 HOME PAGE");
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          print("STATE: $state");
          context.goNamed("/login");
        } else if (state is Authenticated) {
          print("STATE: $state");
          return;
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print("State : $state");
          if (state is AuthLoading) {
            print("STATE: $state");
            return const Center(child: CircularProgressIndicator());
          }

          if (state is Authenticated) {
            print("STATE: $state");
            return _buildHomeContent(firstName(state.user.name ?? "User"));
          } else {
            print("STATE: $state");
            return const Center(child: Text("User tidak terautentikasi"));
          }
        },
      ),
    );
  }

  Widget _buildHomeContent(String email) {
    return Scaffold(
      appBar: AppBar(title: Text("Halo, $email!")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCarousel(),
            12.verticalSpace,
            Text('Survey'),
            12.verticalSpace,
            CustomCardSurvey(
              color: Colors.greenAccent,
              imagePath: "assets/icons/icon paper.png",
              routeName: '/survey-form',
              title: "Survey Kepuasan Matakuliah",
            ),
            12.verticalSpace,
            CustomCardSurvey(
              color: Colors.redAccent,
              imagePath: "assets/icons/icon paper.png",
              routeName: '/survey-form',
              title: "Survey Kepuasan Kinerja Dosen",
            ),
          ],
        ),
      ),
    );
  }
}
