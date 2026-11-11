import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/tasks_bloc.dart';
import 'components/test_task_button.dart';

part 'mobile/view_state.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
    required this.taskTapOpensProperties,
    required this.onOpenTaskProperties,
  });

  final bool taskTapOpensProperties;
  final VoidCallback onOpenTaskProperties;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: BlocListener<TasksBloc, TasksState>(
        listenWhen: (previous, current) =>
            previous.openPropertiesRequestId != current.openPropertiesRequestId,
        listener: (context, state) => onOpenTaskProperties(),
        child: _TasksMobileView(taskTapOpensProperties: taskTapOpensProperties),
      ),
    );
  }
}
