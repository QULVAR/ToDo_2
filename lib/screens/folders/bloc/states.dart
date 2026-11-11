part of 'folders_bloc.dart';

class FoldersState {
  const FoldersState({required this.openListsRequestId});

  final int openListsRequestId;

  FoldersState copyWith({int? openListsRequestId}) {
    return FoldersState(
      openListsRequestId: openListsRequestId ?? this.openListsRequestId,
    );
  }
}
