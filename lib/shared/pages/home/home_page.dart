import 'package:survey_app/core/app/app_exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("📱 HOME PAGE");
    return Scaffold(
      appBar: AppBar(title: const Text("Survey App")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            print("STATE: $state");
            context.goNamed("/login");
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
              return _buildHomeContent(state.user.email ?? "User");
            } else {
              print("STATE: $state");
              return const Center(child: Text("User tidak terautentikasi"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(String email) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCarousel(),
          12.verticalSpace,
          Text('Survey'),
          12.verticalSpace,
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 8.sp,
            crossAxisSpacing: 8.sp,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) => CustomCardSurvey()),
          ),
        ],
      ),
    );
  }
}
