import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/shared/widget/navigation_bar_widget.dart';

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

  //function to change page in Navigation Page
  void goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBarWidget(
        navigationShell: widget.navigationShell,
        goToBranch: goToBranch,
      ),
    );
  }
}
