import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/main_screen/bloc/main_screen_bloc.dart';
import '../screens/main_screen/view.dart';
import '../screens/tasks/properties/properties.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  void _openTaskProperties(BuildContext context) {
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
    return BlocProvider(
      create: (context) => MainScreenBloc(),
      child: BlocListener<MainScreenBloc, MainScreenState>(
        listenWhen: (previous, current) =>
            previous.taskPropertiesRequestId != current.taskPropertiesRequestId,
        listener: (context, state) => _openTaskProperties(context),
        child: const Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(child: MainScreen()),
        ),
      ),
    );
  }
}
