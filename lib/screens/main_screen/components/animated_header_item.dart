import 'package:flutter/material.dart';

class AnimatedHeaderItem extends StatelessWidget {
  const AnimatedHeaderItem({
    super.key,
    required this.id,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 260),
  });

  final String id;
  final bool visible;
  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: visible
          ? KeyedSubtree(key: ValueKey('$id-visible'), child: child)
          : SizedBox(key: ValueKey('$id-hidden')),
    );
  }
}
