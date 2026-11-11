part of 'main_screen_bloc.dart';

class MainScreenState {
  MainScreenState({
    required List<MainScreenPage> pages,
    required this.taskTapOpensProperties,
    required this.taskPropertiesRequestId,
  }) : pages = List.unmodifiable(pages);

  factory MainScreenState.initial() {
    return MainScreenState(
      pages: const [MainScreenPage.folders],
      taskTapOpensProperties: false,
      taskPropertiesRequestId: 0,
    );
  }

  final List<MainScreenPage> pages;
  final bool taskTapOpensProperties;
  final int taskPropertiesRequestId;

  MainScreenPage get currentPage => pages.last;

  MainScreenState copyWith({
    List<MainScreenPage>? pages,
    bool? taskTapOpensProperties,
    int? taskPropertiesRequestId,
  }) {
    return MainScreenState(
      pages: pages ?? this.pages,
      taskTapOpensProperties:
          taskTapOpensProperties ?? this.taskTapOpensProperties,
      taskPropertiesRequestId:
          taskPropertiesRequestId ?? this.taskPropertiesRequestId,
    );
  }
}
