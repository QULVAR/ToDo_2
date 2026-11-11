import 'package:flutter/material.dart';

import '../screens/main_screen/main_screen.dart';
import '../screens/tasks/properties/view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<MainScreenPage> _pages = [MainScreenPage.folders];
  bool _taskTapOpensProperties = false;

  void _openPage(MainScreenPage page) {
    if (_pages.last == page) return;
    setState(() => _pages.add(page));
  }

  void _removePage(MainScreenPage page) {
    if (page == MainScreenPage.folders || !_pages.contains(page)) return;

    setState(() {
      _pages.remove(page);
      if (page == MainScreenPage.tasks) {
        _taskTapOpensProperties = false;
      }
    });
  }

  void _toggleTaskTapMode() {
    setState(() {
      _taskTapOpensProperties = !_taskTapOpensProperties;
    });
  }

  void _openTaskProperties() {
    Navigator.of(context, rootNavigator: true).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        barrierLabel: 'Close task properties',
        pageBuilder: (context, animation, secondaryAnimation) =>
            const TaskPropertiesPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.96,
                end: 1,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: MainScreen(
          pages: _pages,
          onOpenLists: () => _openPage(MainScreenPage.lists),
          onOpenTasks: () => _openPage(MainScreenPage.tasks),
          onPageRemoved: _removePage,
          taskTapOpensProperties: _taskTapOpensProperties,
          onTaskTapModePressed: _toggleTaskTapMode,
          onOpenTaskProperties: _openTaskProperties,
        ),
      ),
    );
  }
}
