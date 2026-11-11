import 'package:flutter_bloc/flutter_bloc.dart';

part 'events.dart';
part 'states.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  ListsBloc() : super(const ListsState(openTasksRequestId: 0)) {
    on<ListsTestListPressed>(_onTestListPressed);
  }

  void _onTestListPressed(
    ListsTestListPressed event,
    Emitter<ListsState> emit,
  ) {
    emit(state.copyWith(openTasksRequestId: state.openTasksRequestId + 1));
  }
}
