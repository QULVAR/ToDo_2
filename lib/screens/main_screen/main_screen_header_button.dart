import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreenHeaderButton extends StatelessWidget {
  const MainScreenHeaderButton({
    super.key,
    required this.assetName,
    required this.onPressed,
  });

  final String assetName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SvgPicture.asset(
        assetName,
        height: 35,
        width: 35,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}
