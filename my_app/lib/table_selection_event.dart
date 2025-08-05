import 'package:equatable/equatable.dart';

abstract class TableSelectionEvent extends Equatable {
  const TableSelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectTable extends TableSelectionEvent {
  final String tableId;

  const SelectTable(this.tableId);

  @override
  List<Object> get props => [tableId];
}

class DeselectTable extends TableSelectionEvent {
  final String tableId;

  const DeselectTable(this.tableId);

  @override
  List<Object> get props => [tableId];
}

class ClearSelection extends TableSelectionEvent {}
