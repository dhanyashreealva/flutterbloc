import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/table_info.dart';
import '../widgets/table_shape.dart';
import '../table_selection_bloc.dart';
import '../table_selection_state.dart';
import '../table_selection_event.dart';

class TableSelectionExamplePage extends StatelessWidget {
  final List<TableInfo> tables = [
    TableInfo(id: 'T1', number: 'R111', type: TableType.circle, position: Offset(20, 20)),
    TableInfo(id: 'T2', number: 'R112', type: TableType.square, position: Offset(80, 20)),
    TableInfo(id: 'T3', number: 'R113', type: TableType.rectangle, position: Offset(140, 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TableSelectionBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Table Selection Example'),
        ),
        body: BlocBuilder<TableSelectionBloc, TableSelectionState>(
          builder: (context, state) {
            return Stack(
              children: tables.map((table) {
                final isSelected = state.selectedTables.contains(table.id);
                return Positioned(
                  left: table.position.dx,
                  top: table.position.dy,
                  child: GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        context.read<TableSelectionBloc>().add(DeselectTable(table.id));
                      } else {
                        if (state.selectedTables.length < 2) {
                          context.read<TableSelectionBloc>().add(SelectTable(table.id));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You can select up to 2 tables only.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: TableShape(
                      table: table,
                      isSelected: isSelected,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
