import 'package:survey_app/core/app/app_exports.dart';

class NavigationPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NavigationPage({
    super.key,
    required this.navigationShell,
    required this.scaffoldKey,
  });

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int selectedIndex = 0;

  void goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBarWidget(
        navigationShell: widget.navigationShell,
        goToBranch: goToBranch,
      ),
    );
  }
}
