import 'package:flutter/material.dart';

class TestListButton extends StatelessWidget {
  const TestListButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: const Text('test-tasks'));
  }
}
