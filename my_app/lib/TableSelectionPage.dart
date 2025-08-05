import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionPage extends StatelessWidget {
  // Define tables with their ids, numbers, types, and positions for layout
  final List<TableInfo> tables = [
    TableInfo(id: 'T1', number: 'R111', type: TableType.circle, position: Offset(20, 20)),
    TableInfo(id: 'T2', number: 'R112', type: TableType.square, position: Offset(80, 20)),
    TableInfo(id: 'T3', number: 'R113', type: TableType.rectangle, position: Offset(140, 20)),
    TableInfo(id: 'T4', number: 'R114', type: TableType.circle, position: Offset(20, 100)),
    TableInfo(id: 'T5', number: 'R115', type: TableType.square, position: Offset(80, 100)),
    TableInfo(id: 'T6', number: 'R116', type: TableType.rectangle, position: Offset(140, 100)),
    // Add more tables as needed with positions approximating the screenshot layout
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableSelectionBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('SELECT TABLE'),
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
          child: Stack(
            children: [
              // Background or restaurant layout can be added here if needed
              BlocBuilder<TableSelectionBloc, TableSelectionState>(
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
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: BlocBuilder<TableSelectionBloc, TableSelectionState>(
                  builder: (context, state) {
                    final isButtonEnabled = state.selectedTables.isNotEmpty;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled ? Color(0xFF2E7D32) : Color(0xFF81C784),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: isButtonEnabled
                            ? () {
                                // TODO: Navigate to next page or perform booking logic
                            }
                            : null,
                        child: Text(
                          'NEXT',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum TableType { circle, square, rectangle }

class TableInfo {
  final String id;
  final String number;
  final TableType type;
  final Offset position;

  TableInfo({
    required this.id,
    required this.number,
    required this.type,
    required this.position,
  });
}

class TableShape extends StatelessWidget {
  final TableInfo table;
  final bool isSelected;

  const TableShape({Key? key, required this.table, required this.isSelected}) : super(key: key);

  Widget _buildChair({required double width, required double height, required BorderRadius borderRadius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected ? Colors.black : Colors.grey.shade400;
    Color backgroundColor = Colors.white;

    Widget? tableShape;

    switch (table.type) {
      case TableType.circle:
        tableShape = Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Center(
            child: Text(
              table.number,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            tableShape,
            Positioned(
              top: 0,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              bottom: 0,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              left: 0,
              child: _buildChair(width: 10, height: 20, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              right: 0,
              child: _buildChair(width: 10, height: 20, borderRadius: BorderRadius.circular(4)),
            ),
          ],
        );
      case TableType.square:
        tableShape = Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Center(
            child: Text(
              table.number,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            tableShape,
            Positioned(
              top: 0,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              bottom: 0,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              left: 0,
              child: _buildChair(width: 10, height: 20, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              right: 0,
              child: _buildChair(width: 10, height: 20, borderRadius: BorderRadius.circular(4)),
            ),
          ],
        );
      case TableType.rectangle:
        tableShape = Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Center(
            child: Text(
              table.number,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            tableShape,
            Positioned(
              top: 0,
              left: 15,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              top: 0,
              right: 15,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              bottom: 0,
              left: 15,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
            Positioned(
              bottom: 0,
              right: 15,
              child: _buildChair(width: 20, height: 10, borderRadius: BorderRadius.circular(4)),
            ),
          ],
        );
    }
    return tableShape!;
  }
}
