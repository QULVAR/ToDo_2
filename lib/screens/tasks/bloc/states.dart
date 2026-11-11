part of 'tasks_bloc.dart';

class TasksState {
  const TasksState({
    required this.testTaskCompleted,
    required this.openPropertiesRequestId,
  });

  final bool testTaskCompleted;
  final int openPropertiesRequestId;

  TasksState copyWith({bool? testTaskCompleted, int? openPropertiesRequestId}) {
    return TasksState(
      testTaskCompleted: testTaskCompleted ?? this.testTaskCompleted,
      openPropertiesRequestId:
          openPropertiesRequestId ?? this.openPropertiesRequestId,
    );
  }
}
