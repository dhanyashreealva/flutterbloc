import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionBloc extends Bloc<TableSelectionEvent, TableSelectionState> {
  TableSelectionBloc() : super(const TableSelectionState()) {
    on<LoadTables>(_onLoadTables);
    on<SelectTable>(_onSelectTable);
  }

  void _onLoadTables(LoadTables event, Emitter<TableSelectionState> emit) async {
    emit(state.copyWith(status: TableStatus.loading));
    await Future.delayed(Duration(milliseconds: 500)); // simulate loading
    emit(state.copyWith(
      status: TableStatus.success,
      availableTables: _mockTableIds,
      bookedTables: ['R111', 'R112'], // some booked for UI
    ));
  }

  void _onSelectTable(SelectTable event, Emitter<TableSelectionState> emit) {
    emit(state.copyWith(selectedTable: event.tableId));
  }

  final List<String> _mockTableIds = [
    'R111', 'R112', 'R113', 'R413', 'R414', 'R415',
    'R416', 'R417', 'R418', 'R419'
  ];
}
