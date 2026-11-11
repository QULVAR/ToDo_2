part of 'main_screen_bloc.dart';

sealed class MainScreenEvent {
  const MainScreenEvent();
}

final class MainScreenPageOpened extends MainScreenEvent {
  const MainScreenPageOpened(this.page);

  final MainScreenPage page;
}

final class MainScreenPageRemoved extends MainScreenEvent {
  const MainScreenPageRemoved(this.page);

  final MainScreenPage page;
}

final class MainScreenTaskTapModeToggled extends MainScreenEvent {
  const MainScreenTaskTapModeToggled();
}

final class MainScreenTaskPropertiesRequested extends MainScreenEvent {
  const MainScreenTaskPropertiesRequested();
}
