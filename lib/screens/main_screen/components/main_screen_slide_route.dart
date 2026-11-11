import 'package:flutter/material.dart';

import 'main_screen_slide_page.dart';

class MainScreenSlideRoute extends PageRoute<void> {
  MainScreenSlideRoute({required MainScreenSlidePage page})
    : super(settings: page);

  MainScreenSlidePage get _page => settings as MainScreenSlidePage;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 320);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 320);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => _page.child;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final primaryPosition = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));
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
  }
}
