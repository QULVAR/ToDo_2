import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key, required this.onListPressed});

  final VoidCallback onListPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(onPressed: onListPressed, child: const Text('test-tasks')),
        ],
      ),
    );
  }
}
