import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todolist/main.dart';
import 'package:todolist/screens/main_screen/main_screen.dart';

void main() {
  testWidgets('dashboard starts on folders', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Folders'), findsOneWidget);
    expect(find.byTooltip('Task tap completes task'), findsNothing);
    expect(find.byKey(const ValueKey('trash-button')), findsNothing);
  });

  testWidgets('task mode button is only shown on tasks', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MainScreen(
          pages: const [
            MainScreenPage.folders,
            MainScreenPage.lists,
            MainScreenPage.tasks,
          ],
          onOpenLists: () {},
          onOpenTasks: () {},
          onPageRemoved: (_) {},
          taskTapOpensProperties: false,
          onTaskTapModePressed: () {},
          onOpenTaskProperties: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('List'), findsOneWidget);
    expect(find.byTooltip('Task tap completes task'), findsOneWidget);
  });

  testWidgets('test buttons open the next routes', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('test-lists'));
    await tester.pumpAndSettle();
    expect(find.text('Folder'), findsOneWidget);
    expect(find.byKey(const ValueKey('trash-button')), findsOneWidget);

    await tester.tap(find.text('test-tasks'));
    await tester.pumpAndSettle();
    expect(find.text('List'), findsOneWidget);

    await tester.tap(find.byTooltip('Task tap completes task'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Task tap opens properties'), findsOneWidget);

    await tester.tap(find.text('test-task-properties'));
    await tester.pumpAndSettle();
    expect(find.text('Task properties'), findsOneWidget);
  });

  testWidgets('task only opens properties while task mode is active', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('test-lists'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('test-tasks'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('test-task-properties'));
    await tester.pumpAndSettle();
    expect(find.text('Task properties'), findsNothing);

    final taskText = tester.widget<Text>(find.text('test-task-properties'));
    expect(taskText.style?.decoration, TextDecoration.lineThrough);

    await tester.tap(find.byTooltip('Task tap completes task'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('test-task-properties'));
    await tester.pumpAndSettle();
    expect(find.text('Task properties'), findsOneWidget);
  });

  testWidgets('back button is hidden on folders and pops nested routes', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    var interaction = tester.widget<IgnorePointer>(
      find.byKey(const ValueKey('back-button-interaction')),
    );
    expect(interaction.ignoring, isTrue);
    final foldersTitleTop = tester.getTopLeft(find.text('Folders')).dy;

    await tester.tap(find.text('test-lists'));
    await tester.pumpAndSettle();
    interaction = tester.widget<IgnorePointer>(
      find.byKey(const ValueKey('back-button-interaction')),
    );
    expect(interaction.ignoring, isFalse);
    expect(tester.getTopLeft(find.text('Folder')).dy, foldersTitleTop);

    await tester.tap(find.text('< Back'));
    await tester.pumpAndSettle();
    expect(find.text('Folders'), findsOneWidget);
    interaction = tester.widget<IgnorePointer>(
      find.byKey(const ValueKey('back-button-interaction')),
    );
    expect(interaction.ignoring, isTrue);
  });
}
