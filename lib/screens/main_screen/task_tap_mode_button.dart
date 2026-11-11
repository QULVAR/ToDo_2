import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskTapModeButton extends StatelessWidget {
  const TaskTapModeButton({
    super.key,
    required this.selected,
    required this.onPressed,
  });

  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: selected
          ? 'Task tap opens properties'
          : 'Task tap completes task',
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: selected
              ? const Color.fromARGB(45, 255, 131, 131)
              : Colors.transparent,
        ),
        child: SvgPicture.asset(
          'assets/icons/plus.svg',
          height: 35,
          width: 35,
          colorFilter: const ColorFilter.mode(
            Color.fromARGB(255, 255, 131, 131),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
