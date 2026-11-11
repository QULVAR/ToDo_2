import 'package:flutter/material.dart';

import '../folders/view.dart';
import '../lists/view.dart';
import '../tasks/view.dart';
import 'animated_header_item.dart';
import 'main_screen_header_button.dart';
import 'main_screen_page.dart';
import 'main_screen_slide_page.dart';
import 'task_tap_mode_button.dart';

export 'main_screen_page.dart';

part 'main_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.pages,
    required this.onOpenLists,
    required this.onOpenTasks,
    required this.onPageRemoved,
    required this.taskTapOpensProperties,
    required this.onTaskTapModePressed,
    required this.onOpenTaskProperties,
  });

  final List<MainScreenPage> pages;
  final VoidCallback onOpenLists;
  final VoidCallback onOpenTasks;
  final ValueChanged<MainScreenPage> onPageRemoved;
  final bool taskTapOpensProperties;
  final VoidCallback onTaskTapModePressed;
  final VoidCallback onOpenTaskProperties;

  @override
  State<MainScreen> createState() => _MainScreenState();
}
