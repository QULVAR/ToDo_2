import 'package:flutter/material.dart';

import '../screens/folders/view.dart';
import '../screens/lists/view.dart';
import '../screens/tasks/view.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          TasksPage(name: 'блять'),
          // Positioned(
          //   child:
          // )
        ],
      ),
    );
  }
}
