import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/main_screen_page.dart';

part 'events.dart';
part 'states.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenState.initial()) {
    on<MainScreenPageOpened>(_onPageOpened);
    on<MainScreenPageRemoved>(_onPageRemoved);
    on<MainScreenTaskTapModeToggled>(_onTaskTapModeToggled);
    on<MainScreenTaskPropertiesRequested>(_onTaskPropertiesRequested);
  }

  void _onPageOpened(
    MainScreenPageOpened event,
    Emitter<MainScreenState> emit,
  ) {
    if (state.currentPage == event.page) return;

    emit(state.copyWith(pages: [...state.pages, event.page]));
  }

  void _onPageRemoved(
    MainScreenPageRemoved event,
    Emitter<MainScreenState> emit,
  ) {
    if (event.page == MainScreenPage.folders ||
        !state.pages.contains(event.page)) {
      return;
    }

    emit(
      state.copyWith(
        pages: state.pages.where((page) => page != event.page).toList(),
        taskTapOpensProperties: event.page == MainScreenPage.tasks
            ? false
            : null,
      ),
    );
  }

  void _onTaskTapModeToggled(
    MainScreenTaskTapModeToggled event,
    Emitter<MainScreenState> emit,
  ) {
    emit(state.copyWith(taskTapOpensProperties: !state.taskTapOpensProperties));
  }

  void _onTaskPropertiesRequested(
    MainScreenTaskPropertiesRequested event,
    Emitter<MainScreenState> emit,
  ) {
    emit(
      state.copyWith(
        taskPropertiesRequestId: state.taskPropertiesRequestId + 1,
      ),
    );
  }
}
