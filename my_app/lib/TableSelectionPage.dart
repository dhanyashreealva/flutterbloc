import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionPage extends StatelessWidget {
  // Define tables with their types and positions for layout
  final List<TableInfo> tables = [
    TableInfo(id: 'T1', type: TableType.square),
    TableInfo(id: 'T2', type: TableType.square),
    TableInfo(id: 'T3', type: TableType.square),
    TableInfo(id: 'T4', type: TableType.square),
    TableInfo(id: 'T5', type: TableType.square),
    TableInfo(id: 'T6', type: TableType.square),
    TableInfo(id: 'T7', type: TableType.square),
    TableInfo(id: 'T8', type: TableType.square),
    TableInfo(id: 'T9', type: TableType.square),
    TableInfo(id: 'T10', type: TableType.square),
    TableInfo(id: 'T11', type: TableType.circle),
    TableInfo(id: 'T12', type: TableType.rectangle),
    TableInfo(id: 'T13', type: TableType.rectangle),
    TableInfo(id: 'T14', type: TableType.rectangle),
    TableInfo(id: 'T15', type: TableType.rectangle),
    TableInfo(id: 'T16', type: TableType.circle),
    TableInfo(id: 'T17', type: TableType.circle),
    TableInfo(id: 'T18', type: TableType.circle),
    TableInfo(id: 'T19', type: TableType.rectangle),
    TableInfo(id: 'T20', type: TableType.rectangle),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableSelectionBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Table(s)'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Select one or two tables from below:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<TableSelectionBloc, TableSelectionState>(
                    builder: (context, state) {
                      final selectedTables = state.selectedTables;

                      return SingleChildScrollView(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: tables.map((table) {
                            final isSelected = selectedTables.contains(table.id);
                            return GestureDetector(
                              onTap: () {
                                if (isSelected) {
                                  context.read<TableSelectionBloc>().add(DeselectTable(table.id));
                                } else {
                                  if (selectedTables.length < 5) {
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
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                BlocBuilder<TableSelectionBloc, TableSelectionState>(
                  builder: (context, state) {
                    final isButtonEnabled = state.selectedTables.isNotEmpty;

                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: isButtonEnabled
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Table(s) booked: ${state.selectedTables.join(', ')}'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  // TODO: Navigate to next page or perform booking logic
                                }
                              : null,
                          child: Text(
                            'BOOK',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum TableType { circle, square, rectangle }

class TableInfo {
  final String id;
  final TableType type;

  TableInfo({required this.id, required this.type});
}

class TableShape extends StatelessWidget {
  final TableInfo table;
  final bool isSelected;

  const TableShape({Key? key, required this.table, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color fillColor;
    switch (table.type) {
      case TableType.circle:
        fillColor = isSelected ? Colors.blue : Colors.grey.shade300;
        break;
      case TableType.square:
        fillColor = isSelected ? Colors.orange : Colors.grey.shade300;
        break;
      case TableType.rectangle:
        fillColor = isSelected ? Colors.green : Colors.grey.shade300;
        break;
    }

    Widget shapeWidget;
    switch (table.type) {
      case TableType.circle:
        shapeWidget = Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: fillColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              table.id,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
        break;
      case TableType.square:
        shapeWidget = Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.orangeAccent : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              table.id,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
        break;
      case TableType.rectangle:
        shapeWidget = Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.greenAccent : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              table.id,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
        break;
    }

    return shapeWidget;
  }
}
