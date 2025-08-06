import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class TableSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8E6E6),
      appBar: AppBar(
        backgroundColor: Color(0xFFD8923C),
        title: Text(
          'Select Table',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ReservationBloc, ReservationState>(
          builder: (context, state) {
            final availableTables = [
              'Circle Table 1',
              'Circle Table 2',
              'Square Table 1',
              'Square Table 2',
              'Rectangle Table 1',
              'Rectangle Table 2',
            ];
            final selectedTable = state.selectedTables.isNotEmpty ? state.selectedTables.first : null;

            bool isTableBooked(String table) {
              return false;
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: availableTables.length,
                      itemBuilder: (context, index) {
                        final table = availableTables[index];
                        final isSelected = selectedTable == table;
                        final booked = isTableBooked(table);

                        return GestureDetector(
                          onTap: booked ? null : () {
                            context.read<ReservationBloc>().add(SelectTable(table));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: booked
                                  ? Colors.grey[300]
                                  : isSelected
                                      ? Color(0xFF2E7D32)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: booked
                                    ? Colors.grey
                                    : isSelected
                                        ? Color(0xFF2E7D32)
                                        : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _getTableIcon(table),
                                  size: 40,
                                  color: booked
                                      ? Colors.grey
                                      : isSelected
                                          ? Colors.white
                                          : Colors.black,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  table,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: booked
                                        ? Colors.grey
                                        : isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                if (booked)
                                  Text(
                                    'Booked',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTable != null
                            ? Color(0xFF2E7D32)
                            : Color(0xFF81C784),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: selectedTable != null
                          ? () {
                              Navigator.pushNamed(context, '/confirmation');
                            }
                          : null,
                      child: Text(
                        'CONFIRM TABLE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  IconData _getTableIcon(String table) {
    if (table.contains('Circle')) {
      return Icons.circle_outlined;
    } else if (table.contains('Square')) {
      return Icons.square_outlined;
    } else if (table.contains('Rectangle')) {
      return Icons.rectangle_outlined;
    }
    return Icons.table_restaurant;
  }
}
