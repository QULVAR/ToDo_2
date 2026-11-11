part of 'main_screen.dart';

class _MainScreenState extends State<MainScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final ValueNotifier<bool> _taskTapMode;

  MainScreenPage get _currentPage => widget.pages.last;

  @override
  void initState() {
    super.initState();
    _taskTapMode = ValueNotifier(widget.taskTapOpensProperties);
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.taskTapOpensProperties != widget.taskTapOpensProperties) {
      _taskTapMode.value = widget.taskTapOpensProperties;
    }
  }

  @override
  void dispose() {
    _taskTapMode.dispose();
    super.dispose();
  }

  void _goBack() {
    _navigatorKey.currentState?.maybePop();
  }

  Widget _buildPage(MainScreenPage page) {
    return switch (page) {
      MainScreenPage.folders => FoldersPage(
        onFolderPressed: widget.onOpenLists,
      ),
      MainScreenPage.lists => ListsPage(onListPressed: widget.onOpenTasks),
      MainScreenPage.tasks => TasksPage(
        taskTapOpensProperties: _taskTapMode,
        onOpenTaskProperties: widget.onOpenTaskProperties,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IgnorePointer(
            key: const ValueKey('back-button-interaction'),
            ignoring: _currentPage == MainScreenPage.folders,
            child: ExcludeSemantics(
              excluding: _currentPage == MainScreenPage.folders,
              child: AnimatedOpacity(
                opacity: _currentPage == MainScreenPage.folders ? 0 : 1,
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
                      key: ValueKey(_currentPage),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _currentPage.title,
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
                  visible: _currentPage == MainScreenPage.tasks,
                  child: TaskTapModeButton(
                    selected: widget.taskTapOpensProperties,
                    onPressed: widget.onTaskTapModePressed,
                  ),
                ),
                AnimatedHeaderItem(
                  id: 'trash-button-animation',
                  visible: _currentPage != MainScreenPage.folders,
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
              onPopWithResult: (result) => _navigatorKey.currentState?.pop(),
              child: Navigator(
                key: _navigatorKey,
                pages: [
                  for (final page in widget.pages)
                    MainScreenSlidePage(
                      key: ValueKey(page),
                      destination: page,
                      child: _buildPage(page),
                    ),
                ],
                onDidRemovePage: (page) {
                  final removedPage = page as MainScreenSlidePage;
                  widget.onPageRemoved(removedPage.destination);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
