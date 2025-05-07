import 'package:survey_app/core/app/app_exports.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Icon(
              Icons.warning_rounded,
              size: 60.sp,
              color: AppColor.error,
            ),
            content: Text(
              "Apakah Anda yakin ingin keluar?",
              style: AppTextStyles.bodyMedium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Batal",
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(SignOutEvent());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                ),
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
          GoRouter.of(context).go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          title: Text("Profile", style: AppTextStyles.h2),
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppColor.error, size: 24.sp),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                24.verticalSpace,
                CircleAvatar(
                  radius: 60.r,
                  backgroundColor: AppColor.primaryColor.withOpacity(0.2),
                  backgroundImage:
                      user?.photoURL != null
                          ? NetworkImage(user!.photoURL!) as ImageProvider
                          : AssetImage('assets/images/default_avatar.png'),
                ),
                16.verticalSpace,
                Text(user?.displayName ?? "No name", style: AppTextStyles.h2),
                4.verticalSpace,
                Text(
                  user?.email ?? "No email",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                24.verticalSpace,
                _buildInfoCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      width: 0.9.sw,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Informasi Pengguna", style: AppTextStyles.h3),
          12.verticalSpace,
          _buildInfoItem("App Version", "1.0.0"),
          _buildInfoItem(
            "Last Login",
            DateTime.now().toString().substring(0, 16),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.textSecondary,
            ),
          ),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
