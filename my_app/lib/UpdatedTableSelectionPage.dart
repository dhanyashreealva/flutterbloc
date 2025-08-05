import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class UpdatedTableSelectionPage extends StatelessWidget {
  const UpdatedTableSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECT TABLE'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => TableSelectionBloc(),
        child: const TableSelectionContent(),
      ),
    );
  }
}

class TableSelectionContent extends StatelessWidget {
  const TableSelectionContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildSectionWithTables('R3/AC', _buildR3Section(context)),
              const Divider(height: 32, thickness: 1),
              _buildSectionWithTables('R2/AC', _buildR2Section(context)),
              const Divider(height: 32, thickness: 1),
              _buildSectionWithTables('R1/non-AC', _buildR1Section(context)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionWithTables(String title, Widget tables) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          tables,
        ],
      ),
    );
  }

  Widget _buildR3Section(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                _buildTable('R413-1', 4, TableShape.rectangle),
                const SizedBox(width: 8),
                _buildTable('R413-2', 4, TableShape.rectangle),
                const SizedBox(width: 8),
                _buildTable('R413-3', 4, TableShape.rectangle),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildTable('R413-4', 4, TableShape.circle),
                const SizedBox(width: 8),
                _buildTable('R413-5', 4, TableShape.circle),
                const SizedBox(width: 8),
                _buildTable('R413-6', 6, TableShape.circle),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildR2Section(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                _buildTable('R413-7', 4, TableShape.rectangle),
                const SizedBox(width: 8),
                _buildTable('R413-8', 4, TableShape.rectangle),
                const SizedBox(width: 8),
                _buildTable('R413-9', 4, TableShape.rectangle),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildTable('R413-10', 4, TableShape.circle),
                const SizedBox(width: 8),
                _buildTable('R413-11', 4, TableShape.circle),
                const SizedBox(width: 8),
                _buildTable('R413-12', 6, TableShape.circle),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildR1Section(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                _buildTable('R111', 2, TableShape.square),
                const SizedBox(width: 8),
                _buildTable('R112', 2, TableShape.square),
                const SizedBox(width: 8),
                _buildTable('R113', 2, TableShape.square),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildTable('R114', 2, TableShape.square),
                const SizedBox(width: 8),
                _buildTable('R115', 2, TableShape.square),
                const SizedBox(width: 8),
                _buildTable('R116', 2, TableShape.square),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTable(String tableId, int chairCount, TableShape shape) {
    return GestureDetector(
      onTap: () {
        context.read<TableSelectionBloc>().add(
          SelectTable(tableId),
        );
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(
            color: Colors.grey.shade600,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          tableId,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
