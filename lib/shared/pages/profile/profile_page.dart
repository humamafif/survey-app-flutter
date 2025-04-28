import 'package:survey_app/core/app/app_exports.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Konfirmasi Logout"),
            content: Text("Apakah Anda yakin ingin keluar?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(SignOutEvent());
                },
                child: Text("Ya"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          print("🚪 User berhasil logout! Arahkan ke halaman login...");
          GoRouter.of(context).go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          title: Text("Profile"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.verticalSpace,
              CircleAvatar(
                radius: 80,
                backgroundImage: Image.network(user?.photoURL ?? "").image,
              ),
              12.verticalSpace,
              Text(user?.displayName ?? "No name"),
              4.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
