import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionBloc extends Bloc<TableSelectionEvent, TableSelectionState> {
  TableSelectionBloc() : super(const TableSelectionState()) {
    on<SelectTable>((event, emit) {
      final updatedSelection = List<String>.from(state.selectedTables);
      if (!updatedSelection.contains(event.tableId)) {
        updatedSelection.add(event.tableId);
      }
      emit(state.copyWith(selectedTables: updatedSelection));
    });

    on<DeselectTable>((event, emit) {
      final updatedSelection = List<String>.from(state.selectedTables);
      updatedSelection.remove(event.tableId);
      emit(state.copyWith(selectedTables: updatedSelection));
    });

    on<ClearSelection>((event, emit) {
      emit(const TableSelectionState(selectedTables: []));
    });
  }
}
