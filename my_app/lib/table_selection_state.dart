import 'package:equatable/equatable.dart';

enum TableStatus { initial, loading, success, failure }

class TableSelectionState extends Equatable {
  final TableStatus status;
  final List<String> availableTables;
  final String? selectedTable;
  final List<String> bookedTables;

  const TableSelectionState({
    this.status = TableStatus.initial,
    this.availableTables = const [],
    this.selectedTable,
    this.bookedTables = const [],
  });

  TableSelectionState copyWith({
    TableStatus? status,
    List<String>? availableTables,
    String? selectedTable,
    List<String>? bookedTables,
  }) {
    return TableSelectionState(
      status: status ?? this.status,
      availableTables: availableTables ?? this.availableTables,
      selectedTable: selectedTable ?? this.selectedTable,
      bookedTables: bookedTables ?? this.bookedTables,
    );
  }

  @override
  List<Object?> get props => [status, availableTables, selectedTable, bookedTables];
}
