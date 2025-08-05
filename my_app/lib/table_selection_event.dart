import 'package:equatable/equatable.dart';

abstract class TableSelectionEvent extends Equatable {
  const TableSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadTables extends TableSelectionEvent {}

class SelectTable extends TableSelectionEvent {
  final String tableId;

  const SelectTable(this.tableId);

  @override
  List<Object> get props => [tableId];
}
