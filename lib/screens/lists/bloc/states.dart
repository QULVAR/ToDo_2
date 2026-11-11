part of 'lists_bloc.dart';

class ListsState {
  const ListsState({required this.openTasksRequestId});

  final int openTasksRequestId;

  ListsState copyWith({int? openTasksRequestId}) {
    return ListsState(
      openTasksRequestId: openTasksRequestId ?? this.openTasksRequestId,
    );
  }
}
