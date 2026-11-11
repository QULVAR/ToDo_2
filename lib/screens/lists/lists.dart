import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/lists_bloc.dart';
import 'components/test_list_button.dart';

part 'mobile/view_state.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key, required this.onOpenTasks});

  final VoidCallback onOpenTasks;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListsBloc(),
      child: BlocListener<ListsBloc, ListsState>(
        listenWhen: (previous, current) =>
            previous.openTasksRequestId != current.openTasksRequestId,
        listener: (context, state) => onOpenTasks(),
        child: const _ListsMobileView(),
      ),
    );
  }
}
