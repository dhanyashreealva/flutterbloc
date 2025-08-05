import 'package:flutter/material.dart';
import '../models/table_info.dart';

class TableShape extends StatelessWidget {
  final TableInfo table;
  final bool isSelected;
  final double scale;

  const TableShape({
    Key? key,
    required this.table,
    required this.isSelected,
    this.scale = 1.0,
  }) : super(key: key);

  Widget _buildChair({required double width, required double height, required BorderRadius borderRadius}) {
    return Container(
      width: width * scale,
      height: height * scale,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSelected ? Colors.green.shade400 : Colors.brown.shade300;
    Color borderColor = isSelected ? Colors.green.shade900 : Colors.brown.shade700;

    Widget? tableShape;

    switch (table.type) {
      case TableType.circle:
        tableShape = Container(
          width: 130 * scale,
          height: 130 * scale,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              table.number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24 * scale,
              ),
            ),
          ),
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            tableShape,
            Positioned(
              top: 10 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              bottom: 10 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              left: 10 * scale,
              child: _buildChair(width: 15, height: 30, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              right: 10 * scale,
              child: _buildChair(width: 15, height: 30, borderRadius: BorderRadius.circular(8)),
            ),
          ],
        );
      case TableType.square:
        tableShape = Container(
          width: 130 * scale,
          height: 130 * scale,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              table.number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24 * scale,
              ),
            ),
          ),
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            tableShape,
            Positioned(
              top: 10 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              bottom: 10 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              left: 10 * scale,
              child: _buildChair(width: 15, height: 30, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              right: 10 * scale,
              child: _buildChair(width: 15, height: 30, borderRadius: BorderRadius.circular(8)),
            ),
          ],
        );
      case TableType.rectangle:
        tableShape = Container(
          width: 130 * scale,
          height: 240 * scale,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Text(
              table.number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24 * scale,
              ),
            ),
          ),
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            tableShape,
            Positioned(
              top: 20 * scale,
              left: 20 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              top: 20 * scale,
              right: 20 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              bottom: 20 * scale,
              left: 20 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
            Positioned(
              bottom: 20 * scale,
              right: 20 * scale,
              child: _buildChair(width: 30, height: 15, borderRadius: BorderRadius.circular(8)),
            ),
          ],
        );
    }
    return tableShape!;
  }
}
