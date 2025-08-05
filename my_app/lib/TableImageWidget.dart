import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

enum TableShape { rectangle, circle, square }

class TableImageWidget extends StatelessWidget {
  final String tableId;
  final bool isSelected;
  final TableShape shape;
  final int chairCount;
  final bool isFaded;

  const TableImageWidget({
    Key? key,
    required this.tableId,
    required this.isSelected,
    required this.shape,
    required this.chairCount,
    this.isFaded = false,
  }) : super(key: key);

  String _getTableImagePath() {
    switch (shape) {
      case TableShape.rectangle:
        if (chairCount <= 4) return 'assets/images/tables/rectangle4.png';
        if (chairCount <= 6) return 'assets/images/tables/rectangle6.png';
        return 'assets/images/tables/rectangle8.png';
      case TableShape.circle:
        if (chairCount <= 2) return 'assets/images/tables/circle2.png';
        if (chairCount <= 4) return 'assets/images/tables/circle4.png';
        return 'assets/images/tables/circle6.png';
      case TableShape.square:
        if (chairCount <= 2) return 'assets/images/tables/square2.png';
        return 'assets/images/tables/square4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isFaded) {
          if (isSelected) {
            context.read<TableSelectionBloc>().add(DeselectTable(tableId));
          } else {
            context.read<TableSelectionBloc>().add(SelectTable(tableId));
          }
        }
      },
      child: Container(
        width: _getTableWidth(),
        height: _getTableHeight(),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: Colors.green, width: 3)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: isFaded ? 0.5 : 1.0,
              child: Image.asset(
                _getTableImagePath(),
                fit: BoxFit.contain,
              ),
            ),
            if (isSelected)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _getTableWidth() {
    switch (shape) {
      case TableShape.rectangle:
        return chairCount <= 4 ? 80 : 100;
      case TableShape.circle:
        return 70;
      case TableShape.square:
        return 60;
    }
  }

  double _getTableHeight() {
    switch (shape) {
      case TableShape.rectangle:
        return 50;
      case TableShape.circle:
        return 70;
      case TableShape.square:
        return 60;
    }
  }
}
