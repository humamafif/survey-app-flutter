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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        iconSize: 28,
        selectedItemColor: AppColor.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColor.backgroundColor,
        currentIndex: currentIndex,
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
         ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
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
