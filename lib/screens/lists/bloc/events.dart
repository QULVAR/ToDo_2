part of 'lists_bloc.dart';

sealed class ListsEvent {
  const ListsEvent();
}

final class ListsTestListPressed extends ListsEvent {
  const ListsTestListPressed();
}
