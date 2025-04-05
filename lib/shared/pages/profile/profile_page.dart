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
                onPressed: () => Navigator.pop(context), // Tutup dialog
                child: Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog sebelum logout
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              70.verticalSpace,
              CircleAvatar(radius: 80, backgroundColor: Colors.grey),
              12.verticalSpace,
              Text("Username"),
              4.verticalSpace,
              Text(user?.email ?? "No email"),
              ElevatedButton(
                onPressed:
                    () => _showLogoutDialog(
                      context,
                    ), // Tampilkan dialog konfirmasi
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
