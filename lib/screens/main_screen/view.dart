import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../folders/folders.dart';
import '../lists/lists.dart';
import '../tasks/tasks.dart';
import 'bloc/main_screen_bloc.dart';
import 'components/animated_header_item.dart';
import 'components/main_screen_header_button.dart';
import 'components/main_screen_page.dart';
import 'components/main_screen_slide_page.dart';
import 'components/task_tap_mode_button.dart';

export 'components/main_screen_page.dart';

part 'mobile/view_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
