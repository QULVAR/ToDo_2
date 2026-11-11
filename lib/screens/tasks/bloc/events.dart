part of 'tasks_bloc.dart';

sealed class TasksEvent {
  const TasksEvent();
}

final class TasksTestTaskPressed extends TasksEvent {
  const TasksTestTaskPressed({required this.openProperties});

  final bool openProperties;
}
