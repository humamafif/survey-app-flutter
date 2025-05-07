import 'package:survey_app/core/app/app_exports.dart';

class NavigationBarWidget extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final void Function(int) goToBranch;

  const NavigationBarWidget({
    super.key,
    required this.navigationShell,
    required this.goToBranch,
  });

  @override
  Widget build(BuildContext context) {
    final int currentIndex = navigationShell.currentIndex;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        iconSize: 24.sp,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.textDisabled,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColor.surfaceColor,
        currentIndex: currentIndex,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 11.sp),
        onTap: (index) {
          goToBranch(index);
        },
        items: [
          _bottomNavbarItem(
            Icon(Icons.home_outlined),
            currentIndex == 0,
            'Home',
          ),
          _bottomNavbarItem(
            Icon(Icons.person_outline),
            currentIndex == 1,
            'Profile',
          ),
        ],
      ),
    );
  }

  // Helper BottomNavigationBarItem
  BottomNavigationBarItem _bottomNavbarItem(
    Icon icon,
    bool isSelected,
    String label,
  ) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
