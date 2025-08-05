import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableSelectionBloc()..add(LoadTables()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildTableLayout()),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.arrow_back),
          Spacer(),
          Text("SELECT TABLE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.home_outlined),
        ],
      ),
    );
  }

  Widget _buildTableLayout() {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        if (state.status == TableStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: state.availableTables.length,
          itemBuilder: (context, index) {
            final tableId = state.availableTables[index];
            final isSelected = tableId == state.selectedTable;
            final isBooked = state.bookedTables.contains(tableId);

            return GestureDetector(
              onTap: isBooked
                  ? null
                  : () {
                      context.read<TableSelectionBloc>().add(SelectTable(tableId));
                    },
              child: Container(
                decoration: BoxDecoration(
                  color: isBooked
                      ? Colors.grey.shade300
                      : isSelected
                          ? Colors.green
                          : Colors.white,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    tableId,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isBooked ? Colors.black45 : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNextButton() {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: state.selectedTable != null
                  ? () {
                      // Navigation or action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Proceeding with ${state.selectedTable}")),
                      );
                    }
                  : null,
              child: Text("NEXT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }
}
