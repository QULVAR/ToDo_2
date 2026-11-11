import 'package:flutter/material.dart';

class TestTaskButton extends StatelessWidget {
  const TestTaskButton({
    super.key,
    required this.completed,
    required this.onPressed,
  });

  final bool completed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'test-task-properties',
        style: TextStyle(
          decoration: completed ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
