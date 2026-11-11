import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/folders_bloc.dart';
import 'components/test_folder_button.dart';

part 'mobile/view_state.dart';

class FoldersPage extends StatelessWidget {
  const FoldersPage({super.key, required this.onOpenLists});

  final VoidCallback onOpenLists;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoldersBloc(),
      child: BlocListener<FoldersBloc, FoldersState>(
        listenWhen: (previous, current) =>
            previous.openListsRequestId != current.openListsRequestId,
        listener: (context, state) => onOpenLists(),
        child: const _FoldersMobileView(),
      ),
    );
  }
}
