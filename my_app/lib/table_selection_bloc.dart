import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionBloc extends Bloc<TableSelectionEvent, TableSelectionState> {
  TableSelectionBloc() : super(const TableSelectionState()) {
    on<SelectTable>(_onSelectTable);
    on<DeselectTable>(_onDeselectTable);
  }

  void _onSelectTable(SelectTable event, Emitter<TableSelectionState> emit) {
    final currentTables = List<String>.from(state.selectedTables);
    if (!currentTables.contains(event.table) && currentTables.length < 2) {
      currentTables.add(event.table);
      emit(state.copyWith(selectedTables: currentTables));
    }
  }

  void _onDeselectTable(DeselectTable event, Emitter<TableSelectionState> emit) {
    final currentTables = List<String>.from(state.selectedTables);
    if (currentTables.contains(event.table)) {
      currentTables.remove(event.table);
      emit(state.copyWith(selectedTables: currentTables));
    }
  }
}
