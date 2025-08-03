import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionPage extends StatelessWidget {
  final List<String> tables = [
    'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10',
    'T11', 'T12', 'T13', 'T14', 'T15', 'T16', 'T17', 'T18', 'T19', 'T20',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableSelectionBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Table(s)'),
          centerTitle: true,
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

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: tables.length,
                        itemBuilder: (context, index) {
                          final table = tables[index];
                          final isSelected = selectedTables.contains(table);

                          return GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                context.read<TableSelectionBloc>().add(DeselectTable(table));
                              } else {
                                if (selectedTables.length < 2) {
                                  context.read<TableSelectionBloc>().add(SelectTable(table));
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? Colors.blueAccent : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  table,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
                          'Book Table(s)',
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
