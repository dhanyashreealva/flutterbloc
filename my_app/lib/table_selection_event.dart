import 'package:equatable/equatable.dart';

abstract class TableSelectionEvent extends Equatable {
  const TableSelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectTable extends TableSelectionEvent {
  final String table;
  const SelectTable(this.table);

  @override
  List<Object> get props => [table];
}

class DeselectTable extends TableSelectionEvent {
  final String table;
  const DeselectTable(this.table);

  @override
  List<Object> get props => [table];
}
