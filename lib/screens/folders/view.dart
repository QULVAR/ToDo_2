import 'package:flutter/material.dart';

class FoldersPage extends StatelessWidget {
  const FoldersPage({super.key, required this.onFolderPressed});

  final VoidCallback onFolderPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: onFolderPressed,
            child: const Text('test-lists'),
          ),
        ],
      ),
    );
  }
}
