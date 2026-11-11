part of 'folders_bloc.dart';

sealed class FoldersEvent {
  const FoldersEvent();
}

final class FoldersTestFolderPressed extends FoldersEvent {
  const FoldersTestFolderPressed();
}
