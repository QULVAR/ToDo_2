import 'package:flutter/material.dart';

import 'main_screen_page.dart';
import 'main_screen_slide_route.dart';

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
    return MainScreenSlideRoute(page: this);
  }
}
