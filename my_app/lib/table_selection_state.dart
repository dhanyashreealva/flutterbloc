import 'package:equatable/equatable.dart';

class TableSelectionState extends Equatable {
  final List<String> selectedTables;

  const TableSelectionState({this.selectedTables = const []});

  TableSelectionState copyWith({List<String>? selectedTables}) {
    return TableSelectionState(
      selectedTables: selectedTables ?? this.selectedTables,
    );
  }

  @override
  List<Object> get props => [selectedTables];
}
