import 'package:flutter_bloc/flutter_bloc.dart';

part 'events.dart';
part 'states.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc()
    : super(
        const TasksState(testTaskCompleted: false, openPropertiesRequestId: 0),
      ) {
    on<TasksTestTaskPressed>(_onTestTaskPressed);
  }

  void _onTestTaskPressed(
    TasksTestTaskPressed event,
    Emitter<TasksState> emit,
  ) {
    if (event.openProperties) {
      emit(
        state.copyWith(
          openPropertiesRequestId: state.openPropertiesRequestId + 1,
        ),
      );
      return;
    }

    emit(state.copyWith(testTaskCompleted: !state.testTaskCompleted));
  }
}
