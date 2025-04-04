import 'package:survey_app/core/app/app_export.dart';

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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) {
          goToBranch(index);
        },
        items: [
          _bottomNavbarItem(Icon(Icons.home), currentIndex == 0, 'Home'),
          _bottomNavbarItem(Icon(Icons.person), currentIndex == 1, 'Profile'),
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
