part of '../view.dart';

class _MainScreenState extends State<MainScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _goBack() {
    _navigatorKey.currentState?.maybePop();
  }

  Widget _buildPage(
    BuildContext context,
    MainScreenPage page,
    MainScreenState state,
  ) {
    return switch (page) {
      MainScreenPage.folders => FoldersPage(
        onOpenLists: () {
          context.read<MainScreenBloc>().add(
            const MainScreenPageOpened(MainScreenPage.lists),
          );
        },
      ),
      MainScreenPage.lists => ListsPage(
        onOpenTasks: () {
          context.read<MainScreenBloc>().add(
            const MainScreenPageOpened(MainScreenPage.tasks),
          );
        },
      ),
      MainScreenPage.tasks => TasksPage(
        taskTapOpensProperties: state.taskTapOpensProperties,
        onOpenTaskProperties: () {
          context.read<MainScreenBloc>().add(
            const MainScreenTaskPropertiesRequested(),
          );
        },
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        final currentPage = state.currentPage;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IgnorePointer(
                key: const ValueKey('back-button-interaction'),
                ignoring: currentPage == MainScreenPage.folders,
                child: ExcludeSemantics(
                  excluding: currentPage == MainScreenPage.folders,
                  child: AnimatedOpacity(
                    opacity: currentPage == MainScreenPage.folders ? 0 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: _goBack,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft,
                        ),
                        child: const Text(
                          '< Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: Align(
                          key: ValueKey(currentPage),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            currentPage.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedHeaderItem(
                      id: 'task-tap-mode',
                      visible: currentPage == MainScreenPage.tasks,
                      child: TaskTapModeButton(
                        selected: state.taskTapOpensProperties,
                        onPressed: () {
                          context.read<MainScreenBloc>().add(
                            const MainScreenTaskTapModeToggled(),
                          );
                        },
                      ),
                    ),
                    AnimatedHeaderItem(
                      id: 'trash-button-animation',
                      visible: currentPage != MainScreenPage.folders,
                      child: MainScreenHeaderButton(
                        key: const ValueKey('trash-button'),
                        assetName: 'assets/icons/trash.svg',
                        onPressed: () {},
                      ),
                    ),
                    MainScreenHeaderButton(
                      assetName: 'assets/icons/plus.svg',
                      onPressed: () {},
                    ),
                    MainScreenHeaderButton(
                      assetName: 'assets/icons/settings.svg',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NavigatorPopHandler<void>(
                  onPopWithResult: (result) =>
                      _navigatorKey.currentState?.pop(),
                  child: Navigator(
                    key: _navigatorKey,
                    pages: [
                      for (final page in state.pages)
                        MainScreenSlidePage(
                          key: ValueKey(page),
                          destination: page,
                          child: _buildPage(context, page, state),
                        ),
                    ],
                    onDidRemovePage: (page) {
                      final removedPage = page as MainScreenSlidePage;
                      context.read<MainScreenBloc>().add(
                        MainScreenPageRemoved(removedPage.destination),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
