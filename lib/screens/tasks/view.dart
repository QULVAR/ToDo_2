import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
    required this.taskTapOpensProperties,
    required this.onOpenTaskProperties,
  });

  final ValueListenable<bool> taskTapOpensProperties;
  final VoidCallback onOpenTaskProperties;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool _completed = false;

  void _onTaskPressed() {
    if (widget.taskTapOpensProperties.value) {
      widget.onOpenTaskProperties();
      return;
    }

    setState(() => _completed = !_completed);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: _onTaskPressed,
            child: Text(
              'test-task-properties',
              style: TextStyle(
                decoration: _completed ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
