import 'package:flutter/material.dart';

import 'main_screen_page.dart';

class MainScreenSlidePage extends Page<void> {
  const MainScreenSlidePage({
    required super.key,
    required this.destination,
    required this.child,
  });

  final MainScreenPage destination;
  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final primaryPosition =
            Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
            );
        final secondaryPosition =
            Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeInOutCubic,
              ),
            );

        return SlideTransition(
          position: secondaryPosition,
          child: SlideTransition(position: primaryPosition, child: child),
        );
      },
    );
  }
}
