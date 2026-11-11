import 'package:flutter/material.dart';

class TestFolderButton extends StatelessWidget {
  const TestFolderButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: const Text('test-lists'));
  }
}
