import 'package:flutter_bloc/flutter_bloc.dart';

part 'events.dart';
part 'states.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  FoldersBloc() : super(const FoldersState(openListsRequestId: 0)) {
    on<FoldersTestFolderPressed>(_onTestFolderPressed);
  }

  void _onTestFolderPressed(
    FoldersTestFolderPressed event,
    Emitter<FoldersState> emit,
  ) {
    emit(state.copyWith(openListsRequestId: state.openListsRequestId + 1));
  }
}
